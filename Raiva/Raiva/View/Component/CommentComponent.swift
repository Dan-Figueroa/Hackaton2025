//
//  CommentComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//

import SwiftUI

struct CommentComponent: View {
    var imageName: String
    var name: String
    var comment: String
    @State private var likeCount: Int = 0
    @State private var isLiked: Bool = false
    
    var body: some View {
        
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(alignment: .top, spacing: 10) {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.top, 5)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(comment)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blanco.opacity(0.4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.verdeBosque.opacity(0.8), lineWidth: 1)
                            )
                    )
                    
                }
                .padding(.horizontal)
                HStack(spacing: 880) {
                    CustomButton(
                        action: {
                            toggleLike()
                        },
                        style: .standard(
                            fontColor: isLiked ? .verdeBosque : .beige,
                            backgroundColor: isLiked ? .beige : .verdeBosque,
                            buttonName: isLiked ? "No me gusta" : "Me gusta"
                        )
                    )
                    .frame(width: 150)
                    
                    InteractionButton(type: .like, count: likeCount)
                        .background(Color.verdeBosque.opacity(0.2))
                }
                .padding(.top, 10)
                .padding(.leading, 60)
                .padding(.bottom, 10)
            }
            .background(Color.clear)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private func toggleLike() {
        isLiked.toggle()
        if isLiked {
            likeCount += 1
        } else {
            likeCount = max(0, likeCount - 1)
        }
    }
}

#Preview {
        List {
            CommentComponent(
                imageName: "perfilInvitado",
                name: "Juan Pérez",
                comment: "Comentario largo sobre los mayas..."
            )
            
            CommentComponent(
                imageName: "perfilInvitado",
                name: "María Gómez",
                comment: "La etnia Maya representa uno de los pueblos indígenas más fascinantes y significativos de Mesoamérica, con una historia que se extiende por más de 3,000 años. Esta cultura milenaria, conocida por sus avanzados conocimientos en astronomía, matemáticas (incluyendo el concepto del cero), arquitectura y un sofisticado sistema de escritura jeroglífica, ha dejado un legado perdurable que continúa influyendo en la identidad cultural de México y Centroamérica. Los mayas no constituyen un grupo homogéneo, sino que se organizan en diversos grupos lingüísticos como los yucatecos, tzotziles, tzeltales, quichés y mames, entre otros, cada uno con sus propias tradiciones y variantes dialectales"
            )
            
            CommentComponent(
                imageName: "perfilInvitado",
                name: "Carlos Ruiz",
                comment: "La etnia Maya representa uno de los pueblos indígenas más fascinantes y significativos de Mesoamérica, con una historia que se extiende por más de 3,000 años. Esta cultura milenaria, conocida por sus avanzados conocimientos en astronomía, matemáticas (incluyendo el concepto del cero), arquitectura y un sofisticado sistema de escritura jeroglífica, "
            )
        }
        .listStyle(.plain)
        
    }

