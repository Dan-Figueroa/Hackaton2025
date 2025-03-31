//
//  LoginViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginCorreo: String = ""
    @Published var loginContraña: String = ""
    @Published var user: User?
    
    private let userService = UserService()
    
    func login(userName: String) async throws {
        Task{
            do{
                let fetchUser = try await userService.obtenerUsuarioPorUser(userName: userName)
                await MainActor.run {
                    self.user = fetchUser
                }
            }catch{
                
            }
        }
        CurrentUser.shared.updateUser(user: user ?? userData)
    }
}
