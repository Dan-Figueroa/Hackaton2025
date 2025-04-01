//
//  CommentSectionViewModel.swift
//  Raiva
//
//  Created by Jesus Ortega on 31/03/25.
//

import Foundation

class CommentSectionViewModel: ObservableObject {
    @Published var content: String = ""
    @Published var commets: [Comment] = []
    
    private let connection: FirebaseConnectable
    private let commentService = CommentService()
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
    }
    
    func cargarCometariosUnaVez(){
        Task{
            do{
                let fetchComentarios = try await commentService.obtenerTodosLosComments()
                await MainActor.run{
                    self.commets = fetchComentarios
                }
            }catch{
                
            }
        }
    }
    
    func cargarComentariosEnTiempoReal(){
        commentService.observarCommentsRealTime{[weak self] comentarios in
            DispatchQueue.main.sync {
                self?.commets = comentarios
            }

        }
    }
    
    func crearComentario(comentario: Comment){
        commentService.guardarComentario(comment: comentario)
    }
    
}
