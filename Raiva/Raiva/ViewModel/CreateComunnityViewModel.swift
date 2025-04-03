//
//  CreateComunnityViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import Foundation
class CreateComunnityViewModel: ObservableObject {
    @Published var communityName: String = "Zoques"
    @Published var communityDescription: String = "La comunidad zoque es una de las principales en la cultura chiapaneca ya que se encuentra en los altos de este y mas cercano a la frontera con veracruz"
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
