//
//  LoginView.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginData = LoginViewModel()
    @State private var rememberMe = false
    @State private var norobot = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.verdeBosque)
                .frame(width: 400, height: 600)
                .border(Color.beige, width: 4)
                .cornerRadius(26)
                .overlay(
                    ZStack {
                        VStack {
                            RaivaLogo(size: .medium)
                                .padding(.top, 40)
                            Spacer()
                        }
                       
                        VStack {
                            HStack {
                                CustomButton(action: {}, style: .image(imageName: "x"))
                                    .scaleEffect(0.5)
                                    .padding(.leading, -5)
                                    .padding(.top, 2)
                                Spacer()
                            }
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
                            title: "Ingresa tu correo",
                            placeholder: "",
                            text: $loginData.loginCorreo,
                            type: .normal,
                            backgroundColor: Color.verdeBosque.opacity(0.8),
                            foregroundColor: .white,
                            width: 300,
                            borderColor: Color.arena
                        )
                        .padding(.bottom, 20)
                        
                        CustomTextField(
                            title: "Ingresa tu contraseña",
                            placeholder: "",
                            text: $loginData.loginContraña,
                            type: .secure,
                            backgroundColor: Color.verdeBosque.opacity(0.8),
                            foregroundColor: .white,
                            width: 300,
                            borderColor: Color.arena
                        )
                        .padding(.bottom, 20)
                        
                        CustomCheckbox(label: "No soy un robot", isChecked: $norobot)
                            .padding(.leading, -130)
                        
                        
                        
                        ZStack() {
                            CustomButton(
                                action: {
                                    
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
                            
                        }, style: .standard(fontColor: .beige, backgroundColor: .verdeBosque, buttonName: "continuar"))
                        .frame(width: 300)
                        
                    }
                )
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppData())
}
