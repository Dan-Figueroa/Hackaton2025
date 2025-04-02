//
//  FirebaseService.swift
//  Raiva
//
//  Created by Jesus Ortega on 22/03/25.
//

import Foundation
import Firebase
import FirebaseDatabase

class ForumService {
    private let connection: FirebaseConnectable
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
    }
  
// MARK: - UPLOAD
    func guardarForo(forum: Forum){
        let forumRef = connection.databaseReference.child("forums")
        let newForumRef = forumRef.childByAutoId()
        
        let forumDict: [String: Any] = [
            "id" : newForumRef.key ?? "Unknown ID",
            "userID" : forum.userID,
            "communityID" : forum.communityID,
            "title" : forum.title,
            "body" : forum.body,
            "likes" : forum.likes,
            "commentCount" : forum.commentCount
        ]
        
        newForumRef.setValue(forumDict){ (error, ref) in
            if let error = error {
                print("error al guardar el foro: \(error)")
            }else {
                print("Foro guardado con exito con ID: \(newForumRef.key ?? "Unknown ID")")
            }
        }
    }
    
    
// MARK: - GET
    
    func observarForosEnTiempoReal(completion: @escaping ([Forum]) -> Void) {
        connection.databaseReference.child("forums").observe(DataEventType.value, with: { (snapshot) in
            
            guard let value = snapshot.value as? [String: Any] else {
                completion([])
                return
            }
            
            var foros: [Forum] = []
            
            for (key, foroData) in value {
                if let foroDict = foroData as? [String: Any],
                   let userID = foroDict["userID"] as? String,
                   let communityID = foroDict["communityID"] as? String,
                   let title = foroDict["title"] as? String,
                   let body = foroDict["body"] as? String,
                   let likes = foroDict["likes"] as? Int,
                   let commentCount = foroDict["commentCount"] as? Int {
                    
                    var foro = Forum(userID: userID, communityID: communityID, title: title, body: body)
                    foro.id = key
                    foro.likes = likes
                    foro.commentCount = commentCount
                    foros.append(foro)
                }
            }
            completion(foros)
        })
    }
    
    /// One request
    func obtenerTodosLosForos() async throws -> [Forum] { // Función que nos da todos los foros con una sola consulta
        do {
            let snapshot = try await connection.databaseReference.child("forums").getData()
            
            guard let value = snapshot.value as? [String: Any] else {
                return []
            }
            
            var foros: [Forum] = []
            for (key, foroData) in value {
                if let foroDict = foroData as? [String: Any],
                   let userID = foroDict["userID"] as? String,
                   let communityID = foroDict["communityID"] as? String,
                   let title = foroDict["title"] as? String,
                   let body = foroDict["body"] as? String,
                   let likes = foroDict["likes"] as? Int,
                   let commentCount = foroDict["commentCount"] as? Int {
                    
                    var foro = Forum(userID: userID, communityID: communityID, title: title, body: body)
                    foro.id = key
                    foro.likes = likes
                    foro.commentCount = commentCount
                    foros.append(foro)
                }
            }
            return foros
        } catch {
            print("Error al obtener los foros: \(error)")
            throw error
        }
    }
    
// MARK: - REMOVE
}

