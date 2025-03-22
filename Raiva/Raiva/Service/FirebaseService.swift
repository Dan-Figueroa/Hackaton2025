//
//  FirebaseService.swift
//  Raiva
//
//  Created by Jesus Ortega on 22/03/25.
//

import Foundation
import Firebase

class FirebaseService {
    static let shared = FirebaseService()
    static let firebase = FirebaseService()
    private let databaseRef = Database.database().reference()
    
    private init() {}
    
    
    // MARK: - Forums functions
    
    func createForum(_ forum: Forum) async throws { // Create a new forum
        let forumRef = databaseRef.child("foros").childByAutoId()
        
        let forumData: [String: Any] = [
            "id" : forum.id,
            "idUser" : forum.idUser,
            "idCommunity" : forum.idCommunity,
            "title" : forum.title,
            "body" : forum.body,
            "likes" : forum.likes,
            "commentCount" : forum.commentCount
        ]
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            forumRef.setValue(forumData) { error, _ in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    // MARK: - User Functions
    
    func createUser(_ user: User) async throws {
        let userRef = databaseRef.child("user").childByAutoId()
        
        let userData: [String: Any] = [
            "id" : user.id,
            "userName" : user.userName,
            "profilePicture" : user.profilePicture,
            "etnia" : user.etnia ??  EtniasEnum.zoque.rawValue
        ]
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in userRef.setValue(userData) { error, _ in
            if let error = error {
                continuation.resume(throwing: error)
            }else {
                continuation.resume()
            }
        }
            
        }
    }
    
    
}
