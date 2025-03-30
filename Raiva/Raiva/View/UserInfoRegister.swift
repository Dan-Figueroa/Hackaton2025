//
//  UserInfoRegister.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//
import SwiftUI

struct UserInfoRegister: View {
    @StateObject private var loginData = LoginViewModel()
    @State private var selectedOption: String? = nil
    let options = [
        ("Si", "si"),
        ("No", "no"),
        ("Prefiero no decirlo", "nose")
    ]
    
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
                        HStack {
                            Circle()
                                .frame(width: 70, height: 70)
                                .padding(.top, 160)
                                .padding(.bottom, 40)
                                .foregroundColor(.verdeBosque)
                                .overlay(
                                    CustomButton(action: {}, style: .image(imageName: "camara"))
                                        .scaleEffect(0.7)
                                        .padding(.top, 160)
                                        .padding(.bottom, 40)
                                )
                            Text("¿Perteneces a un pueblo originario?")
                                .foregroundColor(Color.verdeBosque)
                                .bold()
                                .padding(.top, 160)
                                .padding(.bottom, 40)
                        }
                    
                        ForEach(options, id: \.1) { (label, value) in
                            CustomCheckbox(
                                label: label,
                                isChecked: Binding(
                                    get: { selectedOption == value },
                                    set: { isOn in
                                        if isOn {
                                            selectedOption = value
                                        } else {
                                            selectedOption = nil
                                        }
                                    }
                                )
                            )
                            .padding(.leading, label == "Prefiero no decirlo" ? -95 : -130)
                            .padding(.bottom, 20)
                        }
                        
                        
                        CustomButton(
                            action: {
                              
                                print("Opción seleccionada:", selectedOption ?? "Ninguna")
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
    }
}

#Preview {
    UserInfoRegister()
        .environmentObject(AppData())
}
