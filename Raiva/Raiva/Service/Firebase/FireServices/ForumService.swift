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
// MARK: - REMOVE
}

