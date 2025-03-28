//
//  FireBaseConnection.swift
//  Raiva
//
//  Created by Jesus Ortega on 28/03/25.
//

import Firebase

protocol FirebaseConnectable{ // Protocolo connectable
    var databaseReference: DatabaseReference {get}
}
