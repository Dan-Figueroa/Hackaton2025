//
//  ForoData.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//
import Foundation

class AltaForoViewModel: ObservableObject {
    @Published var selectedEthnicity: Community
    @Published var postTitle: String = ""
    @Published var postContent: String = ""
    
    private var forumService = ForumService()
    
    init(selectedCommunity: Community) {
        self.selectedEthnicity = selectedCommunity
    }
    
    var selectedCommunityName: String {
        selectedEthnicity.communityName
    }
    
    func crearForo(foro: Forum) {
        forumService.guardarForo(forum: foro)
    }
    
    func publicar() {
        guard !postTitle.isEmpty, !postContent.isEmpty else {
            print("Error: Título o contenido vacío")
            return
        }
        
        let nuevoForo = Forum(
            userID: CurrentUser.shared.id,
            communityID: selectedEthnicity.id,
            title: postTitle,
            body: postContent
        )
        
        crearForo(foro: nuevoForo)
        
        // Limpiar después de publicar
        postTitle = ""
        postContent = ""
    }
}
