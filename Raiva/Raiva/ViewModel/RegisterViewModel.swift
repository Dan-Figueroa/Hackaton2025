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
    
    var selectedCommunityName: String {
        selectedEthnicity.rawValue
    }
}
