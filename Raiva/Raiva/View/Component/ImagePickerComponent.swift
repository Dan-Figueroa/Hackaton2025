//
//  ImagePickerComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import SwiftUI

struct ImagePickerComponent: View {
    @Binding var communityProfileImage: String
    let availableImages: [String]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Selecciona una foto")
                .font(.custom("Gagalin", size: 28))
                .foregroundColor(.beige)
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(availableImages, id: \.self) { imageName in
                        Button(action: {
                            communityProfileImage = imageName
                            dismiss()
                        }) {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(communityProfileImage == imageName ? Color.arena : Color.clear, lineWidth: 4)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .frame(minWidth: 600, minHeight: 500)
        .background(Color.verdeBosque)
    }
}
//LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) 3 columnas
