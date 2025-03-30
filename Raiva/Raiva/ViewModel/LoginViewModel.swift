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
}
