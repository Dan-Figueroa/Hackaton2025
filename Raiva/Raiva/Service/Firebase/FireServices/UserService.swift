//
//  UserService.swift
//  Raiva
//
//  Created by Jesus Ortega on 28/03/25.
//

import Foundation
import Firebase
import FirebaseDatabase

class UserService{
    private let connection: FirebaseConnectable
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
    }
    
    // MARK: - Upload
    
    func guardarUsuario(usuario: User) {
        let usersRef = connection.databaseReference.child("users")
        let newUserRef = usersRef.childByAutoId() // Firebase genera un ID único
        
        let usuarioDict: [String: Any] = [
            "id" : newUserRef.key ?? "Unknown",
            "userName": usuario.userName,
            "profilePicture": usuario.profilePicture,
            "etnia": usuario.etnia ?? ""
        ]
        
        newUserRef.setValue(usuarioDict) { (error, ref) in
            if let error = error {
                print("Error al guardar el usuario: \(error)")
            } else {
                print("Usuario guardado con éxito con ID: \(newUserRef.key ?? "Unknown")")
            }
        }
    }
    
    // MARK: - GET
    /// Real time
    func observarUsuariosEnTiempoReal(completion: @escaping ([User]) -> Void) { // Funcion que nos devuelve en tiempo real todos los usuarios
        connection.databaseReference.child("users").observe(DataEventType.value, with: { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else {
                completion([])
                return
            }
            
            var usuarios: [User] = []
            for (key, usuarioData) in value {
                if let usuarioDict = usuarioData as? [String: Any],
                   let userName = usuarioDict["userName"] as? String,
                   let profilePicture = usuarioDict["profilePicture"] as? String,
                   let etnia = usuarioDict["etnia"] as? String? {
                    var usuario = User(userName: userName, profilePicture: profilePicture, etnia: etnia)
                    usuario.id = key
                    usuarios.append(usuario)
                }
            }
            completion(usuarios)
        })
    }
    
    /// One request
    func obtenerTodosLosUsuarios() async throws -> [User] { // Función que nos da todos los usuarios con una sola consulta
        do {
            let snapshot = try await connection.databaseReference.child("users").getData()
            
            guard let value = snapshot.value as? [String: Any] else {
                return []
            }
            
            var usuarios: [User] = []
            for (key, usuarioData) in value {
                if let usuarioDict = usuarioData as? [String: Any],
                   let userName = usuarioDict["userName"] as? String,
                   let profilePicture = usuarioDict["profilePicture"] as? String,
                   let etnia = usuarioDict["etnia"] as? String? {
                    var usuario = User(userName: userName, profilePicture: profilePicture, etnia: etnia)
                    usuario.id = key
                    usuarios.append(usuario)
                }
            }
            return usuarios
        } catch {
            print("Error al obtener los usuarios: \(error)")
            throw error
        }
    }
    
// MARK: - REMOVE
// MARK: - Login
    /// Get user
    func obtenerUsuarioPorID(userName: String) async throws -> User? {
        return try await withCheckedThrowingContinuation { continuation in
            let usersRef = connection.databaseReference.child("users")
            
            usersRef.queryOrdered(byChild: "userName").queryEqual(toValue: userName).observeSingleEvent(of: .value) { (snapshot) in
                
                guard snapshot.exists(), let value = snapshot.value as? [String: [String: Any]] else {
                    print("No se encontró ningún usuario con el ID: \(userName)")
                    continuation.resume(returning: nil)
                    return
                }
                
                for (_, userData) in value {
                    guard let userName = userData["userName"] as? String,
                          let profilePicture = userData["profilePicture"] as? String,
                          let etnia = userData["etnia"] as? String else {
                        print("Error al parsear los datos del usuario")
                        continuation.resume(returning: nil)
                        return
                    }
                    
                    
                    let user = User(id: userName, userName: userName, profilePicture: profilePicture, etnia: etnia)
                    continuation.resume(returning: user)
                    return
                }
                
            } withCancel: { (error) in
                print("Error al obtener el usuario: \(error.localizedDescription)")
                continuation.resume(throwing: error)
            }
        }
    }
}


