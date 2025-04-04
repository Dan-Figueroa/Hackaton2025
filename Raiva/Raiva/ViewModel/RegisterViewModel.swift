//
//  RegisterViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//

import Foundation
class RegisterViewModel: ObservableObject {
    @Published var registerCorreo: String = ""
    @Published var registerContraña: String = ""
    @Published var registerEtnia: String = ""
    @Published var selectedEthnicity: EtniasEnum = .zoque
    @Published var selectedImage: String = "perfilInvitado"
    @Published var shouldContinue = false
    @Published var registrationComplete = false
    
    /// Services
    private var userService = UserService()
    
    @Published var availableImages: [String] = [
        "perfilInvitado", "cool", "jesus", "nina", "nino",
        "imagen1", "imagen2", "imagen3", "imagen4", "imagen5","imagen6","imagen7","imgaen8",   "imagen9","imagen10","imagen11","imagen12","imagen13","imqgen14","imagen15","imagen16","imagen17"
    ]
    
    var selectedCommunityName: String {
        selectedEthnicity.rawValue
    }
    
    func agregarUsuario(user: User) {
            userService.guardarUsuario(usuario: user) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let userWithID):
                        // Actualizar el estado con el usuario que incluye el ID
                        self?.registrationComplete = true
                        // Aquí podrías también actualizar CurrentUser.shared si es necesario
                    case .failure(let error):
                        print("Error al guardar usuario: \(error.localizedDescription)")
                        // Manejar el error adecuadamente
                    }
                }
            }
        }
}
