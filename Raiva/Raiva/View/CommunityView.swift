//
//  Community.swift
//  Raiva
//
//  Created by Dan Figueroa on 02/04/25.
//

import SwiftUI

struct CommunityView: View {
    @StateObject private var communityVM = CreateComunnityViewModel()
    @StateObject private var misComunidadesViewModel = MisComunidadesViewModel()
    @Binding var showCommunity: Bool
    @Binding var community: Community
    @State private var showAltaForo = false
    
    @State var isJoined: Bool = false
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 900, height: 700)
                .foregroundColor(.verdeBosque)
                .opacity(0.9)
                .cornerRadius(30)
            
            VStack(spacing: 0) {
                ZStack {
                    Image(community.communityProfileImage)
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
                        Image(community.communityProfileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                        
                        Circle()
                            .stroke(Color.arena, lineWidth: 3)
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, 70)
                .padding(.top, 90)
            
            VStack(alignment: .leading, spacing: 10) {
               
                Text(community.communityName)
                    .font(.custom("Gagalin", size: 30))
                    .foregroundColor(.beige)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 40)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
              
                ScrollView {
                    Text(community.communityDescription)
                        .font(.custom("Gagalin", size: 15))
                        .foregroundColor(.beige)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 40)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(height: 80)
             
                HStack(spacing: -180) {
                    CustomButton(
                        action: {
                            showAltaForo = true
                        },
                        style: .imageWithText(
                            imageName: "crear",
                            text: "CREAR PUBLICACION",
                            fontColor: .beige,
                            isSelected: false
                        )
                    ).frame(width: 530)
                    .scaleEffect(0.5)
                    
                    if !isJoined{
                        CustomButton(
                            action: {
                                misComunidadesViewModel.subirForumUser(fu: ForumUsers(userID: CurrentUser.shared.id, forumID: community.id))
                                
                                
                                isJoined.toggle()
                            },
                            style: .standard(
                                fontColor: .beige,
                                backgroundColor: .arena.opacity(0.4),
                                buttonName: "UNIRSE"
                            )
                        )
                        .frame(width: 140)
                    }
                }
                .padding(.leading,330)
                
                ScrollView {
                    Rectangle().frame(width: 800, height:170 )
                        .foregroundColor(.verdeBosque)
                        .cornerRadius(30)
                }
            }
            .frame(width: 800, alignment: .leading)
            .padding(.top, 290)
         
            CustomButton(action: {
                showCommunity = false
            }, style: .image(imageName: "x"))
            .scaleEffect(0.8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 20)
            .padding(.top, 20)
        }
        .frame(width: 900, height: 700)
        .sheet(isPresented: $showAltaForo) {
            AltaForo(isPresented: $showAltaForo, comunidadSeleccionada: communityData)
            .presentationBackground(.clear)
    }
    }
}

#Preview {
    // Crear un binding para showCommunity
    let showCommunity = Binding<Bool>(
        get: { false },
        set: { _ in }
    )
    
    // Crear un binding para community con datos de ejemplo
    let community = Binding<Community>(
        get: {
            Community(
                communityName: "Comunidad de Surf",
                communityDescription: "Un lugar para los amantes del surf y el océano",
                communityProfileImage: "surf_profile",
                communityPortraitImage: "surf_portrait",
                communityOwner: "user123"
            )
        },
        set: { _ in }
    )
    
    CommunityView(
        showCommunity: showCommunity,
        community: community
    )
}
