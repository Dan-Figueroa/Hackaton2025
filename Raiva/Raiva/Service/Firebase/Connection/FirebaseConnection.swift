//
//  FirebaseConection.swift
//  Raiva
//
//  Created by Jesus Ortega on 28/03/25.
//

import Firebase

final class FirebaseConnection: FirebaseConnectable{
    let databaseReference: DatabaseReference
    static let shared = FirebaseConnection()
    
    private init(){
        databaseReference = Database.database().reference()
    }
}
