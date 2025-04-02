//
//  LoginViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginUsername: String = ""
    @Published var loginContraseña: String = ""
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var isWrong: Bool = false
    @Published var errorMessage: String?
    
    private let userService = UserService()
    
    func login() async {
        guard !loginUsername.isEmpty else {
            await MainActor.run {
                errorMessage = "El nombre de usuario no puede estar vacío"
            }
            return
        }
        
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let fetchedUser = try await userService.obtenerUsuarioPorUser(userName: loginUsername)
            
            await MainActor.run {
                if let fetchedUser = fetchedUser {
                    self.user = fetchedUser
                    print("MADAFAAAK\(fetchedUser.id)")
                    CurrentUser.shared.updateUser(user: fetchedUser)
                    errorMessage = nil
                } else {
                    errorMessage = "Usuario no encontrado"
                }
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = "Error al iniciar sesión: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
}
