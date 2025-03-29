//
//  ComunityService.swift
//  Raiva
//
//  Created by Jesus Ortega on 29/03/25.
//

import Foundation
import Firebase
import FirebaseDatabase

class CommunityService {
    private let connection: FirebaseConnectable
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
    }
    
// MARK: - UPLOAD
    
    func guardarComunidad(comunidad: Community) {
        let commRef = connection.databaseReference.child("comunidad")
        let newCommRef = commRef.childByAutoId()
        
        let commDict: [String: Any] = [
            "id" : newCommRef.key ?? "",
            "communityName" : comunidad.communityName,
            "communityDescription" : comunidad.communityDescription,
            "communityProfileImage" : comunidad.communityProfileImage,
            "communityPortraitImage" : comunidad.communityPortraitImage,
            "communityOwner" : comunidad.communityOwner
        ]
        
        newCommRef.setValue(commDict){ (error, ref) in
            if let error = error {
                print("Error al guardar la comunidad: \(error)")
            }else{
                print("comunidad guardada con éxito con ID: \(newCommRef.key ?? "Unknow ID")")
            }
            
            
        }
    }
    
// MARK: - GET
// MARK: - REMOVE
    
}
