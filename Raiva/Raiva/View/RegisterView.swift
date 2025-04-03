//
//  RegisterView.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var registerViewModel = RegisterViewModel()
    @State private var rememberMe = false
    @State private var norobot = false
    @ObservedObject var coordinator: RegistrationCoordinator
    
    var body: some View {
        ZStack {
            // Fondo verde con logo
            Rectangle()
                .foregroundColor(Color.verdeBosque)
                .frame(width: 400, height: 600)
                .cornerRadius(26)
                .overlay(
                    VStack {
                        RaivaLogo(size: .medium)
                            .padding(.top, 40)
                        Spacer()
                    }
                    .frame(width: 400, height: 600)
                )
            
            // Formulario de registro
            Rectangle()
                .foregroundColor(Color.beige)
                .frame(width: 400, height: 480)
                .cornerRadius(26)
                .offset(y: 70)
                .overlay(
                    VStack {
                        // Título
                        Text("Registro")
                            .foregroundColor(Color.verdeBosque)
                            .bold()
                            .font(.largeTitle)
                            .padding(.top, 100)
                            .padding(.bottom, 10)
                        
                        // Campo de usuario/correo
                        CustomTextField(
                            title: "Ingresa tu usuario",
                            placeholder: "",
                            text: $registerViewModel.registerCorreo,
                            type: .normal,
                            backgroundColor: Color.verdeBosque.opacity(0.8),
                            foregroundColor: .white,
                            tittleColor: Color.black,
                            width: 300,
                            borderColor: Color.arena
                        )
                        .padding(.bottom, 20)
                        
                        // Campo de contraseña
                        CustomTextField(
                            title: "Ingresa tu contraseña",
                            placeholder: "",
                            text: $registerViewModel.registerContraña,
                            type: .secure,
                            backgroundColor: Color.verdeBosque.opacity(0.8),
                            foregroundColor: .white,
                            tittleColor: Color.black,
                            width: 300,
                            borderColor: Color.arena
                        )
                        .padding(.bottom, 20)
                        
                        // Checkbox "No soy un robot"
                        CustomCheckbox(
                            label: "No soy un robot",
                            isChecked: $norobot
                        )
                        .padding(.leading, -130)
                        .padding(.bottom, 20)
                        
                        // Botón de continuar
                        CustomButton(
                            action: {
                                coordinator.isUserInfoViewPresented = true
                            },
                            style: .standard(
                                fontColor: .beige,
                                backgroundColor: .verdeBosque,
                                buttonName: "continuar"
                            )
                        )
                        .frame(width: 300)
                    }
                )
        }
        .background(Color.clear)
        // Sheet para información adicional del usuario
        .sheet(isPresented: $coordinator.isUserInfoViewPresented) {
            UserInfoRegister(coordinator: coordinator)
                .environmentObject(AppData())
                .presentationBackground(.clear)
                .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    RegisterView(coordinator: RegistrationCoordinator())
        .environmentObject(AppData())
}
