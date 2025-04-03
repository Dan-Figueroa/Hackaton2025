//
//  CummunityForumComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import SwiftUI

struct CommunityForumComponent: View {
    let communityName: String
    let communityIcon: String
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            VStack(spacing: size * 0.05) {
                
                Image(communityIcon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size * 0.4, height: size * 0.4)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.arena, lineWidth: 2))
                
                Text(communityName)
                    .font(.custom("Gagalin", size: size * 0.25))
                    .foregroundColor(Color.arena.opacity(0.8))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

#Preview {
    CommunityForumComponent(communityName: "Hola", communityIcon: "perfilInvitado")
        .environmentObject(AppData())
}
