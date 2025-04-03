//
//  RegistrationCoordinator.swift
//  Raiva
//
//  Created by Dan Figueroa on 03/04/25.
//

import Foundation

class RegistrationCoordinator: ObservableObject {
    @Published var isRegisterViewPresented = false
    @Published var isUserInfoViewPresented = false
    
    func completeRegistration() {
        isUserInfoViewPresented = false
        isRegisterViewPresented = false
    }
}
