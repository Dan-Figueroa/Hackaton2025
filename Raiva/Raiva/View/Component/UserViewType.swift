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
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                )
                
            case .horizontal:
                return AnyView(
                                GeometryReader { geometry in
                                    let containerSize = min(geometry.size.width, geometry.size.height)
                                    
                                    HStack(spacing: containerSize * 0.05) {
                                        Image(imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: containerSize * 0.4, height: containerSize * 0.4)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.green.opacity(0.5), lineWidth: containerSize * 0.015)
                                            )
                                        
                                        Text(name)
                                            .font(.custom("Gagalin", size: containerSize * 0.2))
                                            .foregroundColor(Color.arena)
                                            .minimumScaleFactor(0.5)
                                            .lineLimit(1)
                                        
                                        Spacer()
                                    }
                                    .padding(containerSize * 0.05)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                }
                            )
            }
        }
    }

#Preview {
    UserViewType(imageName: "perfilInvitado", name: "Meliza Gonzales", style: .horizontal)
}
