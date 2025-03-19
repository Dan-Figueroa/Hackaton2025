//
//  ForumComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import SwiftUI

struct ForumComponent: View {
    @EnvironmentObject var appData: AppData
    let forumData: Forum
    var body: some View {
        
        ZStack{
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundStyle(Color.verdeBosque.opacity(0.65))
                .frame(width: .infinity, height: .infinity)
            
            VStack(){
                headData()
                    .frame(width: appData.UISW * 0.7, height: 100)
                bodyData(tittle: forumData.title)
                Spacer()
                
            }
            
        }.frame(width: .infinity, height: .infinity)
    }
}

private struct headData: View{
    var body: some View {
        HStack{
            UserViewType(imageName: "perfilInvitado", name: "Meliza Gonzales", style: .horizontal)
            Spacer()
            CommunityForumComponent(communityName: "Chol", communityIcon: "perfilInvitado")
        }
        .frame(width: .infinity, height: .infinity)
    }
}

private struct bodyData: View {
    let tittle: String
    var body: some View {
        VStack(){
            HStack{
                Text(tittle)
                    .font(.custom("Gagalin", size: 30))
                    .foregroundStyle(Color.beige)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
        }
    }
}



#Preview {
    ForumComponent(forumData: Forum(idUser: "a", idCommunity: "a", title: "¿Qué tan importante es la cultura?", body: "a"))
        .frame(width: 900, height: 300)
        .environmentObject(AppData())
}
