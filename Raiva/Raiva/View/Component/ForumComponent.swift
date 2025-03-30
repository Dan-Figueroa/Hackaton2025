//
//  ForumComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import SwiftUI

struct ForumComponent: View {
    @EnvironmentObject var appData: AppData
    let communityData: Community
    let userData: User
    let forumData: Forum
    
    var body: some View {
        VStack(){
            HeadData(userImageName: userData.profilePicture, userName: userData.userName, communityName: communityData.communityName, communityIcon: communityData.communityProfileImage)
                .frame(height: appData.UISH * 0.12)
            
            BodyData(tittle: forumData.title, bodyText: forumData.body)
            
            FooterData(likeCount: forumData.likes, commentCount: forumData.commentCount)
                .padding(.top, 10)
        }
        .padding()
        .background(
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundStyle(Color.verdeBosque.opacity(0.70))
        )
        .frame(maxWidth: .infinity)
    }
}

// MARK: - HeadData

private struct HeadData: View{
    let userImageName: String
    let userName: String
    let communityName: String
    let communityIcon: String
    var body: some View {
        HStack{
            UserViewType(imageName: userImageName, name: userName, style: .horizontal)
            Spacer()
            CommunityForumComponent(communityName: communityName, communityIcon: communityIcon)
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}

// MARK: - BodyData

private struct BodyData: View {
    let tittle: String
    let bodyText: String
    var body: some View {
        VStack(alignment: .leading){
            Text(tittle)
                .font(.custom("Gagalin", size: 30))
                .foregroundStyle(Color.beige)
                .padding(.bottom, 10)
            Text(bodyText)
                .font(.custom("Futura", size: 25))
                .foregroundStyle(Color.beige)
                .padding(.leading, 20)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
    }
}

// MARK: - FooterData

private struct FooterData: View {
    @State var likeCount: Int? = nil
    @State var commentCount: Int? = nil
    var body: some View{
        HStack(spacing: 15){
            InteractionButton(type: .like, count: likeCount)
            InteractionButton(type: .comment, count: commentCount)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 50)
    }
}

struct InteractionButton: View {
    enum InteractionType {
        case like
        case comment
    }
    
    let type: InteractionType
    var count: Int? = nil
    @State private var isLiked: Bool = false
    
    var body: some View {
        Button(action: handleAction) {
            HStack(spacing: 3) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 30)
                
                if let count = count, count > 0 {
                    Text("\(count)")
                        .font(.custom("Gagalin", size: 24))
                        .foregroundStyle(Color.arena)
                }
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 12)
            .background(Color.white.opacity(0.17))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
    
    private var imageName: String {
        switch type {
        case .like:
            return isLiked ? "like" : "LikeVacio"
        case .comment:
            return "comentario"
        }
    }
    
    private func handleAction() {
        if type == .like {
            isLiked.toggle()
            print("Falta lógia pa")
        } else {
            print("Meterse a la sección de comentarios")
        }
    }
}

// MARK: - TestStructs

let communityData: Community = .init(
    id: "fdds",
    communityName: "CholesEstudiantes",
    communityDescription: "Prueba de descripcion de comunidad",
    communityProfileImage: "perfilInvitado",
    communityPortraitImage: "portraitImage"
)

let userData: User = .init(
    userName: "Jesús Ortega",
    profilePicture: "perfilInvitado",
    etnia: EtniasEnum.chol.rawValue
)

let forumData: Forum = .init(
    userID: "OMTqvi6Xs7BYl8y1ZRQ",
    communityID: "chol",
    title: "Lorem ipsum dolor sit amet",
    body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    likes: 1,
    commentCount: 10000000
)

#Preview {
    //    FooterData()
    ForumComponent(communityData: communityData, userData: userData, forumData: forumData)
        .environmentObject(AppData())
        .frame(width: 1000)
    //    LikeComponent()
}
