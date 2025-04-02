//
//  ForoData.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//
import Foundation

class AltaForoViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var selectedEthnicity: EtniasEnum = .zoque
    @Published var postTitle: String = ""
    @Published var postContent: String = ""
    
    private var forumService = ForumService()

    var selectedCommunityName: String {
        selectedEthnicity.rawValue
    }
    
    func crearForo(foro: Forum){
        forumService.guardarForo(forum: foro)
    }
    
    func publicar(){
        let comunidad = selectedEthnicity
        let tittle = postTitle
        let content = postContent
        
        crearForo(foro: Forum(userID: CurrentUser.shared.id, communityID: comunidad.rawValue, title: tittle, body: content))
    }
}
