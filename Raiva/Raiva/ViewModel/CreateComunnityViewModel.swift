//
//  CreateComunnityViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import Foundation
class CreateComunnityViewModel: ObservableObject {
    @Published var nameComunnity: String = ""
    @Published var descriptionComunnity: String = ""
    @Published var selectedImage: String = "perfilInvitado" 
    @Published var availableImages: [String] = [
        "perfilInvitado", "chol", "festividadChol", "chuj", "mam",
        "qanjobal", "tojolabal", "tsotsil", "tseltal", "zoque"
    ]
}
