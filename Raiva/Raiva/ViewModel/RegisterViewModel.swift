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
    
    @Published var availableImages: [String] = [
        "perfilInvitado", "cool", "jesus", "nina", "nino",
        "imagen1", "imagen2", "imagen3", "imagen4", "imagen5","imagen6","imagen7","imgaen8",   "imagen9","imagen10","imagen11","imagen12","imagen13","imqgen14","imagen15","imagen16","imagen17"
    ]
    
    var selectedCommunityName: String {
        selectedEthnicity.rawValue
    }
}
