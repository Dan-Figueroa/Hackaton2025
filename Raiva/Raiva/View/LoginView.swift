//
//  LoginView.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var rememberMe = false
    @State private var norobot = false
    @StateObject private var registrationCoordinator = RegistrationCoordinator()
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.verdeBosque)
                .frame(width: 400, height: 600)
            //.border(Color.beige, width: 4)
                .cornerRadius(26)
                .overlay(
                    ZStack {
                        VStack {
                            RaivaLogo(size: .medium)
                                .padding(.top, 30)
                            Spacer()
                        }
                    }
                        .frame(width: 400, height: 600)
                )
            
            Rectangle()
                .foregroundColor(Color.beige)
                .frame(width: 400, height: 480)
                .cornerRadius(26)
                .offset(y: 70)
                .overlay(
                    VStack {
                        Text("Iniciar sesion")
                            .foregroundColor(Color.verdeBosque)
                            .bold()
                            .font(.largeTitle)
                            .padding(.top, 130)
                            .padding(.bottom, 20)
                        
                        CustomTextField(
                            title: loginViewModel.isWrong ? "Usuario incorrecto" : "Ingresa tu usuario",
                            placeholder: "",
                            text: $loginViewModel.loginUsername,
                            type: .normal,
                            backgroundColor: Color.verdeBosque.opacity(0.8),
                            foregroundColor: .white, tittleColor: (loginViewModel.isWrong) ? Color.red : Color.black,
                            width: 300,
                            borderColor: Color.arena
                        )
                        .padding(.bottom, 20)
                        
                        CustomTextField(
                            title: "Ingresa tu contraseña",
                            placeholder: "",
                            text: $loginViewModel.loginContraseña,
                            type: .secure,
                            backgroundColor: Color.verdeBosque.opacity(0.8),
                            foregroundColor: .white, tittleColor: .black,
                            width: 300,
                            borderColor: Color.arena
                        )
                        .padding(.bottom, 20)
                        
                        CustomCheckbox(label: "No soy un robot", isChecked: $norobot)
                            .padding(.leading, -130)
                        
                        
                        
                        ZStack() {
                            CustomButton(
                                action: {
                                
                                    registrationCoordinator.isRegisterViewPresented = true
                                },
                                style: .standard(
                                    fontColor: .verdeBosque,
                                    backgroundColor: .beige,
                                    buttonName: "regístrate"
                                )
                            ).padding(.leading, 170)
                            
                            Text("¿Aun no eres miembro?")
                                .foregroundColor(.verdeBosque)
                                .padding(.leading, -100)
                        }
                        .frame(height: 40)
                        
                        CustomButton(action: {
                            Task {
                                await loginViewModel.login()
                                
                                if loginViewModel.user != nil {
                            
                                    print("Login exitoso para el usuario: \(loginViewModel.user?.userName ?? "")")
                                    if let user = loginViewModel.user {
                                        if loginViewModel.isWrong == true {
                                            loginViewModel.isWrong.toggle()
                                        }
                                        CurrentUser.shared.updateUser(user: user)
                                        dismiss()
                                    }
                                } else if let error = loginViewModel.errorMessage {
                                    loginViewModel.isWrong.toggle()
                                    print("Eerror en login: \(error)")
                                }
                                print("Usuario actual:\(CurrentUser.shared.id)")
                            }
                        }, style: .standard(fontColor: .beige, backgroundColor: .verdeBosque, buttonName: "continuar"))
                        .frame(width: 300)
                        
                    }
                )
        }.sheet(isPresented: $registrationCoordinator.isRegisterViewPresented) {
            RegisterView(coordinator: registrationCoordinator)
                .environmentObject(AppData())
                .presentationBackground(.clear)
                .interactiveDismissDisabled(true)
        }
        
            
    }
}

#Preview {
    LoginView()
        .environmentObject(AppData())
}
