//
//  UserInfoRegister.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//
import SwiftUI

struct UserInfoRegister: View {
    @StateObject private var registerData = RegisterViewModel()
    @State private var rememberMe = false
    @State private var si = false
    @State private var no = false
    @State private var nose = false
    
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
                        HStack {
                            Circle()
                            .frame(width: 70, height: 70)
                            .padding(.top, 160)
                            .padding(.bottom, 40)
                            .foregroundColor(.verdeBosque)
                            .overlay(
                                CustomButton(action: {
                                    
                                }, style: .image(imageName: "camara")).scaleEffect(0.7)
                                    .padding(.top, 160)
                                    .padding(.bottom, 40)
                            )
                            Text("¿Perteneces a un pueblo originario?")
                                .foregroundColor(Color.verdeBosque)
                                .bold()
                                .padding(.top, 160)
                                .padding(.bottom, 20)
                        }
                        
                        CustomCheckbox(label: "Si", isChecked: $si)
                            .padding(.leading, -130)
                            .padding(.bottom, 10)
                            .onChange(of: si) {
                                if si {
                                    no = false
                                    nose = false
                                }
                            }
                        
                        if si {
                            Picker("Selecciona una comunidad", selection: $registerData.selectedEthnicity) {
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
                                text: $registerData.registerEtnia,
                                type: .normal,
                                backgroundColor: Color.beige,
                                foregroundColor: .black,
                                width: 200,
                                borderColor: Color.arena
                            )
                            .padding(.bottom, 20)
                        }
                        
                        CustomCheckbox(label: "No", isChecked: $no)
                            .padding(.leading, -130)
                            .padding(.bottom, 20)
                            .onChange(of: no) {
                                if no {
                                    si = false
                                    nose = false
                                }
                            }
                        
                        CustomCheckbox(label: "Prefiero no decirlo", isChecked: $nose)
                            .padding(.leading, -95)
                            .padding(.bottom, 20)
                            .onChange(of: nose) {
                                if nose {
                                    si = false
                                    no = false
                                }
                            }
                        
                        CustomButton(action: {
                            
                        }, style: .standard(fontColor: .beige, backgroundColor: .verdeBosque, buttonName: "continuar"))
                        .frame(width: 300)
                    }
                )
        }
    }
}
#Preview {
    UserInfoRegister()
        .environmentObject(AppData())
}
