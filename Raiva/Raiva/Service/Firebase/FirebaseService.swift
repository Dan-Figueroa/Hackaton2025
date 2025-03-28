//
//  FirebaseService.swift
//  Raiva
//
//  Created by Jesus Ortega on 22/03/25.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseService {
    private let connection: FirebaseConnectable
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
    }
    
    // MARK: - Forums functions
    ///  Upload
    
    /// Read
    
    
    
    // MARK: - User Functions
    /// Update
    func guardarUsuario(usuario: User) {
        let usersRef = connection.databaseReference.child("users")
        let newUserRef = usersRef.childByAutoId() // Firebase genera un ID único
        
        let usuarioDict: [String: Any] = [
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
    
    /// Read
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
}
