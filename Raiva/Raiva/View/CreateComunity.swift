//
//  CreateComunity.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//

import SwiftUI

struct CreateComunity: View {
    @StateObject private var createComunnityData = CreateComunnityViewModel()
    @State private var showImagePicker = false
    @State private var selectedImage: String = "perfilInvitado"
    
    let availableImages = ["chol", "festividadChol", "chuj", "mam","qanjobal","tojolabal","tsotsil","tseltal","zoque", "perfilInvitado"]
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 900, height: 700)
                .foregroundColor(.verdeBosque)
                .opacity(0.9)
                .cornerRadius(30)
            
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.arena.opacity(0.3))
                    .frame(height: 180)
                    .cornerRadius(30)
                Spacer()
            }
            .frame(width: 900, height: 700)
            
            Circle()
                .fill(Color.arena.opacity(0.3))
                .frame(width: 180, height: 180)
                .overlay(
                    ZStack {
                        Image(selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                        Circle()
                            .stroke(Color.arena, lineWidth: 3)
                        
                        VStack(spacing: 5) {
                            CustomButton(action: {
                                showImagePicker.toggle()
                            }, style: .image(imageName: "camara"))
                            Text("Agregar foto")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, 70)
                .padding(.top, 90)
            
            VStack(spacing: 40) {
                CustomTextField(
                    title: "Nombre",
                    placeholder: "",
                    text: $createComunnityData.nameComunnity,
                    type: .normal,
                    backgroundColor: Color.verdeBosque.opacity(0.3),
                    foregroundColor: .white,
                    width: 800,
                    borderColor: Color.arena
                )
                
                CustomTextField(
                    title: "Descripción",
                    placeholder: "",
                    text: $createComunnityData.descriptionComunnity,
                    type: .textEditor,
                    backgroundColor: Color.verdeBosque.opacity(0.3),
                    foregroundColor: .white,
                    width: 800,
                    borderColor: Color.arena
                )
                
                CustomButton(action: {
                    
                }, style: .standard(fontColor: .arena, backgroundColor: .verdeBosque.opacity(0.8), buttonName: "Publicar"))
                .frame(width: 200)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 40)
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 10)
            .padding(.top, 330)
            
            CustomButton(action: {}, style: .image(imageName: "x"))
                .scaleEffect(0.8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, 20)
                .padding(.top, 20)
        }
        .frame(width: 900, height: 700)
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(selectedImage: $selectedImage, availableImages: availableImages)
        }
    }
}
struct ImagePickerView: View {
        @Binding var selectedImage: String
        let availableImages: [String]
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            VStack {
                Text("Selecciona una foto")
                    .font(.title)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        ForEach(availableImages, id: \.self) { imageName in
                            Button(action: {
                                selectedImage = imageName
                                dismiss()
                            }) {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(selectedImage == imageName ? Color.arena : Color.clear, lineWidth: 4)
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .frame(minWidth: 600, minHeight: 500)
            .background(Color.verdeBosque.opacity(0.1))
        }
    }

#Preview {
    CreateComunity()
}
