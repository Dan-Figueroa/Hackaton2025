//
//  CommentSectionComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 31/03/25.
//

import SwiftUI

struct CommentSectionComponent: View {
    @StateObject var commentSectionViewModel = CommentSectionViewModel()
    var body: some View {
        VStack{
            ForumComponent(communityData: communityData, userData: userData, forumData: forumData, withBackground: false) // Foro
            CommentField(text: $commentSectionViewModel.content) // Comentar
            
            
            
        }.background(
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundStyle(Color.verdeBosque.opacity(0.70))
        )
    }
}

struct CommentField: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            CustomTextField(
                title: "",
                placeholder: "Agrega un comentario",
                text: $text,
                type: isEditing ? .textEditor : .normal,
                backgroundColor: .white.opacity(0.17),
                foregroundColor: .white.opacity(0.5),
                tittleColor: .skin,
                width: .infinity,
                borderColor: .arena.opacity(0.21)
            )
            .onTapGesture {
                isEditing = true
            }
            
            if isEditing {
                buttons(
                    cancelButton: {
                        isEditing = false
                        text = ""
                    },
                    commentButton: {
                        // Lógica para publicar el comentario
                    }
                )
                .frame(width: 250, height: 50)
                .offset(x: 430, y: 30)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(50)
    }
}

private struct buttons: View {
    let cancelButton: () -> Void
    let commentButton: () -> Void
    var body: some View {
        HStack(spacing: -30){
            Group{
                CustomButton(action: cancelButton, style: .standard(fontColor: .verdeBosque, backgroundColor: .white, buttonName: "Cancelar"))
                CustomButton(action: commentButton, style: .standard(fontColor: .white, backgroundColor: .verdeBosque, buttonName: "Comentar"))
            }.scaleEffect(0.8)
        }.frame(width: .infinity, height: .infinity)
    }
}

#Preview {
    CommentSectionComponent()
        .environmentObject(AppData())
    //CommentField(viewModel: CommentSectionViewModel())
    //buttons()
}
