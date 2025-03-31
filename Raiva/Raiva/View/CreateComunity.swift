//
//  CreateComunity.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//
import SwiftUI

struct CreateComunity: View {
    @StateObject private var createComunnityVM = CreateComunnityViewModel()
    @State private var showImagePicker = false
    @Binding var showCreateComunity: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 900, height: 700)
                .foregroundColor(.verdeBosque)
                .opacity(0.9)
                .cornerRadius(30)
            
            VStack(spacing: 0) {
                ZStack {
                    Image(createComunnityVM.selectImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .offset(y: 80)
                        .blur(radius: 1)
                    
                    Rectangle()
                        .foregroundColor(.black.opacity(0.5))
                        .cornerRadius(30)
                }
                .frame(height: 180)
                .cornerRadius(30)
                
                Spacer()
            }
            .frame(width: 900, height: 700)
            
            Circle()
                .fill(Color.arena.opacity(0.4))
                .frame(width: 180, height: 180)
                .overlay(
                    ZStack {
                        Image(createComunnityVM.selectImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                        
                        Circle()
                            .stroke(Color.arena, lineWidth: 3)
                        
                        if createComunnityVM.selectImage == "perfilInvitado" {
                            VStack(spacing: 5) {
                                CustomButton(action: {
                                    showImagePicker.toggle()
                                }, style: .image(imageName: "camara"))
                                Text("Agregar foto")
                                    .foregroundColor(.white)
                                    .bold()
                            }
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
                    text: $createComunnityVM.communityName,
                    type: .normal,
                    backgroundColor: Color.verdeBosque.opacity(0.3),
                    foregroundColor: .white,
                    tittleColor: .black,
                    width: 800,
                    borderColor: Color.arena
                )
                
                CustomTextField(
                    title: "Descripción",
                    placeholder: "",
                    text: $createComunnityVM.communityDescription,
                    type: .textEditor,
                    backgroundColor: Color.verdeBosque.opacity(0.3),
                    foregroundColor: .white,
                    tittleColor: .black,
                    width: 800,
                    borderColor: Color.arena
                )
                
                CustomButton(action: {
                    createComunnityVM.crearComunidad(
                        comunidad: createComunnityVM.returnComunity(
                            communityName: createComunnityVM.communityName,
                            communityDescription: createComunnityVM.communityDescription,
                            communityProfileImage: createComunnityVM.selectImage,
                            communityOwner: CurrentUser.shared.id)
                    )
                }, style: .standard(fontColor: .arena, backgroundColor: .verdeBosque.opacity(0.8), buttonName: "Publicar"))
                .frame(width: 200)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 10)
            .padding(.top, 330)
            
            CustomButton(action: {
                showCreateComunity = false
            }, style: .image(imageName: "x"))
            .scaleEffect(0.8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 20)
            .padding(.top, 20)
        }
        .frame(width: 900, height: 700)
        .sheet(isPresented: $showImagePicker) {
            ImagePickerComponent(selectImage: $createComunnityVM.selectImage, availableImages: createComunnityVM.availableImages)
        }
    }
}

#Preview {
    CreateComunity(showCreateComunity: .constant(true))
}
