//
//  ForosUsuariosService.swift
//  Raiva
//
//  Created by Jesus Ortega on 03/04/25.
//

import Foundation
import Firebase
import FirebaseDatabase

class ForumUsersService {
    private let connection: FirebaseConnectable
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
    }
  
    // MARK: - UPLOAD
    func guardarForumUsers(forumUsers: ForumUsers) {
        let forumUsersRef = connection.databaseReference.child("forumUsers")
        let newForumUsersRef = forumUsersRef.childByAutoId()
        
        let forumUsersDict: [String: Any] = [
            "id": newForumUsersRef.key ?? "Unknown ID",
            "userID": forumUsers.userID,
            "forumID": forumUsers.forumID,
            "members": forumUsers.members
        ]
        
        newForumUsersRef.setValue(forumUsersDict) { (error, ref) in
            if let error = error {
                print("Error al guardar forumUsers: \(error)")
            } else {
                print("ForumUsers guardado con éxito con ID: \(newForumUsersRef.key ?? "Unknown ID")")
            }
        }
    }
    
    // MARK: - GET
    func observarForumUsersEnTiempoReal(completion: @escaping ([ForumUsers]) -> Void) {
        connection.databaseReference.child("forumUsers").observe(DataEventType.value, with: { (snapshot) in
            
            guard let value = snapshot.value as? [String: Any] else {
                completion([])
                return
            }
            
            var forumUsersArray: [ForumUsers] = []
            
            for (key, forumUserData) in value {
                if let forumUserDict = forumUserData as? [String: Any],
                   let userID = forumUserDict["userID"] as? String,
                   let forumID = forumUserDict["forumID"] as? String,
                   let members = forumUserDict["members"] as? Int {
                    
                    var forumUser = ForumUsers(userID: userID, forumID: forumID, members: members)
                    forumUser.id = key
                    forumUsersArray.append(forumUser)
                }
            }
            completion(forumUsersArray)
        })
    }
    
    /// One request
    func obtenerTodosLosForumUsers() async throws -> [ForumUsers] {
        do {
            let snapshot = try await connection.databaseReference.child("forumUsers").getData()
            
            guard let value = snapshot.value as? [String: Any] else {
                return []
            }
            
            var forumUsersArray: [ForumUsers] = []
            for (key, forumUserData) in value {
                if let forumUserDict = forumUserData as? [String: Any],
                   let userID = forumUserDict["userID"] as? String,
                   let forumID = forumUserDict["forumID"] as? String,
                   let members = forumUserDict["members"] as? Int {
                    
                    var forumUser = ForumUsers(userID: userID, forumID: forumID, members: members)
                    forumUser.id = key
                    forumUsersArray.append(forumUser)
                }
            }
            return forumUsersArray
        } catch {
            print("Error al obtener los forumUsers: \(error)")
            throw error
        }
    }
}
