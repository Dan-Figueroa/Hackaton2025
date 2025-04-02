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
    
    func obtenerTodasLasComunidades() async throws -> [Community] {
        do {
            let snapshot = try await connection.databaseReference.child("communities").getData()
            
            guard let value = snapshot.value as? [String: Any] else {
                return []
            }
            
            var comunidades: [Community] = []
            for (key, comunidadData) in value {
                if let comunidadDict = comunidadData as? [String: Any],
                   let communityName = comunidadDict["communityName"] as? String,
                   let communityDescription = comunidadDict["communityDescription"] as? String,
                   let communityProfileImage = comunidadDict["communityProfileImage"] as? String,
                   let communityPortraitImage = comunidadDict["communityPortraitImage"] as? String,
                   let communityOwner = comunidadDict["communityOwner"] as? String {
                    
                    var comunidad = Community(communityName: communityName,
                                            communityDescription: communityDescription,
                                            communityProfileImage: communityProfileImage,
                                            communityPortraitImage: communityPortraitImage,
                                            communityOwner: communityOwner)
                    comunidad.id = key
                    comunidades.append(comunidad)
                }
            }
            return comunidades
        } catch {
            print("Error al obtener las comunidades: \(error)")
            throw error
        }
    }
    
// MARK: - REMOVE
    
}
