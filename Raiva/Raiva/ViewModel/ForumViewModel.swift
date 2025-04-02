//
//  ForumViewModel.swift
//  Raiva
//
//  Created by Jesus Ortega on 27/03/25.
//

import Foundation
import Combine

class ForumViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var forums: [Forum] = []
    @Published var errorMessage: String?
    @Published var user: User?
    
    private let connection: FirebaseConnectable
    private let userService = UserService()
    private let forumService = ForumService()
    private let communityService = CommunityService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
        cargarForosEnTiempoReal()
    }
    
    func cargarForosEnTiempoReal(){
        forumService.observarForosEnTiempoReal{ [weak self] foros in
            DispatchQueue.main.async{
                self?.forums = foros
            }
        }
    }
    
    func cargarForosOnce(){
        Task{
            do{
                let fetchedForos = try await forumService.obtenerTodosLosForos()
                await MainActor.run{
                    self.forums = fetchedForos
                }
            }catch{
                print("Error de cargar usuarios: \(error)")
            }
        }
    }
    
    func cargarUsuariosEnTiempoReal() {
        userService.observarUsuariosEnTiempoReal { [weak self] usuarios in
            DispatchQueue.main.async {
                self?.users = usuarios
            }
        }
    }
    func agregarUsuario(user: User) {
        userService.guardarUsuario(usuario: user)
    }
    func crearForo(userID: String, foro: Forum){
        forumService.guardarForo(forum: foro)
    }
    
    func getUsuarioPorUserName(userName: String) {
        Task {
            do {
                let fetchedUser = try await userService.obtenerUsuarioPorUser(userName: userName)
                await MainActor.run {
                    self.user = fetchedUser
                }
            } catch {
                print("Error al obtener usuario por ID: \(error)")
                await MainActor.run {
                    self.errorMessage = "No se pudo obtener el usuario con ID: \(userName)"
                }
            }
        }
    }
    
}
