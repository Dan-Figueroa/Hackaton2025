//
//  CreateComunnityViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import Foundation
class CreateComunnityViewModel: ObservableObject {
    @Published var communityName: String = ""
    @Published var communityDescription: String = ""
    @Published var selectImage: String = "perfilInvitado" // communityProfileImage
    
    @Published var availableImages: [String] = [
        "perfilInvitado", "chol", "festividadChol", "chuj", "mam",
        "qanjobal", "tojolabal", "tsotsil", "tseltal", "zoque"
    ]
    
    
    private var communityService = CommunityService()
    
    func crearComunidad(comunidad: Community){
        communityService.guardarComunidad(comunidad: comunidad)
    }
    
    func returnComunity(communityName: String, communityDescription: String,communityProfileImage: String, communityOwner: String) -> Community{
        let community: Community = Community(communityName: communityName, communityDescription: communityDescription, communityProfileImage: communityProfileImage, communityPortraitImage: communityProfileImage, communityOwner: communityOwner)
        return community
    }
}
