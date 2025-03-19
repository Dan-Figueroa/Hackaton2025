//
//  UserViewType.swift
//  Raiva
//
//  Created by Dan Figueroa on 19/03/25.
//
import SwiftUI

struct UserViewType: View {
    let imageName: String
    let name: String
    let style: ProfileDisplayStyle

    var body: some View {
        style.profileView(imageName: imageName, name: name)
    }
}
    enum ProfileDisplayStyle {
        case vertical
        case horizontal
        
        func profileView(imageName: String, name: String) -> some View {
            switch self {
                
            case .vertical:
                return AnyView(
                    VStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.green.opacity(0.5), lineWidth: 5)
                            )
                        Text(name)
                            .font(.custom("Gagalin", size: 24))
                            .foregroundStyle(Color.arena)
                            
                    }
                    .frame(maxWidth: .infinity)
                )
                
            case .horizontal:
                return AnyView(
                    HStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.green.opacity(0.5), lineWidth: 3)
                            )
                        
                        Text(name)
                            .font(.custom("Gagalin", size: 24))
                            .foregroundStyle(Color.arena)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                )
            }
        }
    }

#Preview {
    UserViewType(imageName: "perfilInvitado", name: "Meliza Gonzales", style: .vertical)
}
