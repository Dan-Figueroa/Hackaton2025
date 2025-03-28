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
    @Published var errorMessage: String?
    
    private let connection: FirebaseConnectable
    private let firebaseService = FirebaseService()
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
        cargarUsuariosEnTiempoReal()
    }

    func cargarUsuariosUnaVez() {
            Task {
                do {
                    let fetchedUsuarios = try await firebaseService.obtenerTodosLosUsuarios()
                    await MainActor.run {
                        self.users = fetchedUsuarios
                    }
                } catch {
                    print("Error al cargar usuarios: \(error)")
                    // Manejar el error apropiadamente (por ejemplo, mostrar una alerta)
                }
            }
        }
    
    func cargarUsuariosEnTiempoReal() {
            firebaseService.observarUsuariosEnTiempoReal { [weak self] usuarios in
                DispatchQueue.main.async {
                    self?.users = usuarios
                }
            }
        }

    func agregarUsuario(user: User) {
            firebaseService.guardarUsuario(usuario: user)
        }
}
