//
//  InfoRectangle.swift
//  Raiva
//
//  Created by Dan Figueroa on 21/03/25.
//

import SwiftUI

struct InfoRectangle: View {
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color.verdeBosque)
            .frame(width: 400, height: 400)
            .cornerRadius(30)
            .overlay(
                VStack(spacing: 50) {
                    Text(title)
                        .foregroundColor(.beige)
                        .font(.custom("Gagalin", size: 40))
                        .padding(.top, 20)
                    Text(subtitle)
                        .foregroundColor(.beige)
                        .font(.custom("Gagalin", size: 30))
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
            )
            .padding(.horizontal, 10)
    }
}
