//
//  UserInfoRegister.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//
import SwiftUI

struct UserInfoRegister: View {
    @StateObject private var registerViewModel = RegisterViewModel()
    @State private var si = false
    @State private var no = false
    @State private var nose = false
    @State private var showImagePicker = false
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
                            .padding(.top, 30)
                        Spacer()
                    }
                )
            
            // Formulario de información
            Rectangle()
                .foregroundColor(Color.beige)
                .frame(width: 400, height: 480)
                .cornerRadius(26)
                .offset(y: 70)
                .overlay(
                    VStack {
                        // Foto de perfil y pregunta
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.verdeBosque)
                                
                                Image(registerViewModel.selectedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 65, height: 65)
                                    .clipShape(Circle())
                                
                                if registerViewModel.selectedImage == "perfilInvitado" {
                                    CustomButton(
                                        action: { showImagePicker.toggle() },
                                        style: .image(imageName: "camara")
                                    )
                                    .scaleEffect(0.7)
                                }
                            }
                            .padding(.top, 160)
                            .padding(.bottom, 40)
                            
                            Text("¿Perteneces a un pueblo originario?")
                                .foregroundColor(Color.verdeBosque)
                                .bold()
                                .padding(.top, 160)
                                .padding(.bottom, 20)
                        }
                        
                        // Opción Sí
                        CustomCheckbox(label: "Si", isChecked: $si)
                            .padding(.leading, -130)
                            .padding(.bottom, 10)
                            .onChange(of: si) {
                                if si {
                                    no = false
                                    nose = false
                                }
                            }
                        
                        // Selector de etnia (si seleccionó Sí)
                        if si {
                            Picker("Selecciona una comunidad", selection: $registerViewModel.selectedEthnicity) {
                                ForEach(EtniasEnum.allCases, id: \.self) { ethnicity in
                                    Text(ethnicity.rawValue).tag(ethnicity)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.bottom, 20)
                            .frame(width: 150, height: 40)
                            .background(Color.verdeBosque)
                            .cornerRadius(10)
                            .foregroundColor(.arena)
                            
                            CustomTextField(
                                title: "otro:",
                                placeholder: "",
                                text: $registerViewModel.registerEtnia,
                                type: .normal,
                                backgroundColor: Color.beige,
                                foregroundColor: .black,
                                tittleColor: Color.black,
                                width: 200,
                                borderColor: Color.arena
                            )
                            .padding(.bottom, 20)
                        }
                        
                        // Opción No
                        CustomCheckbox(label: "No", isChecked: $no)
                            .padding(.leading, -130)
                            .padding(.bottom, 20)
                            .onChange(of: no) {
                                if no {
                                    si = false
                                    nose = false
                                }
                            }
                        
                        // Opción Prefiero no decirlo
                        CustomCheckbox(label: "Prefiero no decirlo", isChecked: $nose)
                            .padding(.leading, -95)
                            .padding(.bottom, 20)
                            .onChange(of: nose) {
                                if nose {
                                    si = false
                                    no = false
                                }
                            }
                        
                        // Botón de continuar
                        CustomButton(
                            action: {
                                registerViewModel.agregarUsuario(user: User(
                                    userName: registerViewModel.registerCorreo,
                                    profilePicture: registerViewModel.selectedImage,
                                    etnia: registerViewModel.selectedEthnicity.rawValue
                                ))
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
        // Selector de imagen
        .sheet(isPresented: $showImagePicker) {
            ImagePickerComponent(
                selectImage: $registerViewModel.selectedImage,
                availableImages: registerViewModel.availableImages
            )
        }
        // Cierre al completar registro
        .onChange(of: registerViewModel.registrationComplete) { oldValue, newValue in
            if newValue {
                coordinator.completeRegistration()
            }
        }
    }
}

#Preview {
    UserInfoRegister(coordinator: RegistrationCoordinator())
        .environmentObject(AppData())
}
