//
//  CommentService.swift
//  Raiva
//
//  Created by Jesus Ortega on 31/03/25.
//

import Foundation
import Firebase
import FirebaseDatabase

class CommentService {
    private let connection: FirebaseConnectable
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
    }
    
//MARK: - POST
    
    func guardarComentario(comment: Comment){
        let commentRef = connection.databaseReference.child("comments")
        let newComment = commentRef.childByAutoId()
        
        let commentDic: [String: Any] = [
            "id": newComment.key ?? "unknown",
            "userID": comment.userID,
            "forumID": comment.forumID,
            "title": comment.title,
            "body": comment.body
        ]
        
        newComment.setValue(commentDic){ (error, ref) in
            if let error = error{
                print("Error al guardar el comentario: \(error)")
            }else{
                print( "Comentario guardado con éxito con ID: \(newComment.key ?? "unknown")")
            }
            
        }
            
    }
    
    
//MARK: - Update
//MARK: - GET
    /// Once
    func obtenerTodosLosComments()async throws -> [Comment]{
        
        do{
            let snapshot = try await connection.databaseReference.child("comments").getData()
            
            guard let value = snapshot.value as? [String: Any] else {
                return []
            }
            
            var comments: [Comment] = []
            for(key, commentData) in value{
                if let commentDic = commentData as? [String: Any],
                   let userID = commentDic["userID"] as? String,
                   let forumID = commentDic["forumID"] as? String,
                   let tittle = commentDic["tittle"] as? String,
                   let body = commentDic["body"] as? String {
                    
                    var comment = Comment(userID: userID, forumID: forumID, title: tittle, body: body)
                    
                    comment.id = key
                    comments.append(comment)
                    
                }
            }
            return comments
        }catch{
            print("Error al obtener los comentarios: \(error)")
            throw error
        }
    }
    
    /// REAL TIME
    func observarCommentsRealTime(completation: @escaping([Comment]) -> Void){
        connection.databaseReference.child("users").observe(DataEventType.value, with: { (snapshot) in
            
            guard let value = snapshot.value as? [String: Any] else{
                completation([])
                return
            }
            
            var comments: [Comment] = []
            
            for(key, commentData) in value{
                if let commentDic = commentData as? [String: Any],
                   let userID = commentDic["userID"] as? String,
                   let forumID = commentDic["forumID"] as? String,
                   let tittle = commentDic["tittle"] as? String,
                   let body = commentDic["body"] as? String {
                    
                    var comment = Comment(userID: userID, forumID: forumID, title: tittle, body: body)
                    
                    comment.id = key
                    comments.append(comment)
                    
                }
            }
            completation(comments)
        })
    }
}
