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
            headData(userImageName: userData.profilePicture, userName: userData.userName, communityName: communityData.communityName, communityIcon: communityData.communityProfieImage)
                .frame(width: appData.UISW * 0.7, height: 100)
            
            bodyData(tittle: forumData.title, bodyText: forumData.body)
            
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

private struct headData: View{
    let userImageName: String
    let userName: String
    let communityName: String
    let communityIcon: String
    var body: some View {
        HStack{
            UserViewType(imageName: userImageName, name: userName, style: .horizontal)
            Spacer()
            CommunityForumComponent(communityName: communityName, communityIcon: communityIcon)
        }
    }
}

private struct bodyData: View {
    let tittle: String
    let bodyText: String
    var body: some View {
        VStack(alignment: .leading){
            Text(tittle)
                .font(.custom("Gagalin", size: 30))
                .foregroundStyle(Color.beige)
            Text(bodyText)
                .font(.custom("Futura", size: 25))
                .foregroundStyle(Color.beige)
                .padding(.leading, 20)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
    }
}

private struct footerData: View {
    var body: some View{
        Text("place holder")
    }
}

let communityData: Community = .init(
    id: "fdds",
    communityName: "CholesEstudiantes",
    communityDescription: "Prueba de descripcion de comunidad",
    communityProfieImage: "perfilInvitado",
    communityPortraitImage: "portraitImage"
)

let userData: User = .init(
    id: "A",
    userName: "Jesús Ortega",
    profilePicture: "perfilInvitado",
    etnia: EtniasEnum.chol.rawValue
)

let forumData: Forum = .init(
    id: "a",
    idUser: "Jesus Ortega",
    idCommunity: "chol",
    title: "Hola",
    body: "O",
    likes: 1,
    commentCount: 10
)

#Preview {
    ForumComponent(communityData: communityData, userData: userData, forumData: forumData)
        .frame(width: 900)
        .environmentObject(AppData())
}
