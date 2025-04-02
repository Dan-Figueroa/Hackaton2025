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
    @State private var showSheet = false
    
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
                                .padding(.top, 40)
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
                        Text("Registro")
                            .foregroundColor(Color.verdeBosque)
                            .bold()
                            .font(.largeTitle)
                            .padding(.top, 100)
                            .padding(.bottom, 10)
                        
                        CustomTextField(
                            title: "Ingresa tu usuario",
                            placeholder: "",
                            text: $registerViewModel.registerCorreo,
                            type: .normal,
                            backgroundColor: Color.verdeBosque.opacity(0.8),
                            foregroundColor: .white, tittleColor: Color.black,
                            width: 300,
                            borderColor: Color.arena
                        )
                        .padding(.bottom, 20)
                        
                        CustomTextField(
                            title: "Ingresa tu contraseña",
                            placeholder: "",
                            text: $registerViewModel.registerContraña,
                            type: .secure,
                            backgroundColor: Color.verdeBosque.opacity(0.8),
                            foregroundColor: .white, tittleColor: Color.black,
                            width: 300,
                            borderColor: Color.arena
                        )
                        
                        .padding(.bottom, 20)
                        
                        CustomCheckbox(label: "No soy un robot", isChecked: $norobot)
                            .padding(.leading, -130)
                            .padding(.bottom, 20)
                        
                        CustomButton(action: {
                            showSheet = true
                        }, style: .standard(fontColor: .beige, backgroundColor: .verdeBosque, buttonName: "continuar"))
                        .frame(width: 300)
                        
                    }
                    .sheet(isPresented: $showSheet) {
                        UserInfoRegister()
                        .environmentObject(AppData())
                        .presentationBackground(.clear)
                        .interactiveDismissDisabled(true)

                    }
                )
        }.background(Color.clear)
    }
}


#Preview {
    RegisterView()
        .environmentObject(AppData())
}
