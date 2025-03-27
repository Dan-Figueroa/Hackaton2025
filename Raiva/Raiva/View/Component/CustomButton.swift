//
//  CustomButton.swift
//  Raiva
//
//  Created by Daniel Figueroa on 13/03/25.
//

import SwiftUI

enum ButtonStyle {
    case standard(fontColor: Color, backgroundColor: Color, buttonName: String)
    case imageWithText(imageName: String, text: String, fontColor: Color, isSelected: Bool)
    case image(imageName: String)
    case viewStruct(() -> AnyView)
    case smallImage(imageName: String)
}

struct CustomButton: View {
    let action: () -> Void
    let style: ButtonStyle
    
    var body: some View {
        switch style {
        case .standard(let fontColor, let backgroundColor, let buttonName):
            Button {
                action()
            } label: {
                Text(buttonName)
                    .font(.custom("Gagalin", size: 16))
                    .foregroundStyle(fontColor)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(backgroundColor, in: .rect(cornerRadius: 20))
            .padding(.horizontal)
            
        case .imageWithText(let imageName, let text, let fontColor, let isSelected):
            Button(action: {
                action()
            }) {
                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    Text(text)
                        .font(.custom("Gagalin", size: 26))
                        .foregroundStyle(fontColor)
                        .underline(isSelected)
                }
                .cornerRadius(8)
            }
        case .image(imageName: let imageName):
            Button(action: {
                action()
            }) {
                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                .cornerRadius(8)
            }
        case .viewStruct(let viewBuilder):
            Button {
                action()
            } label: {
                AnyView{
                    viewBuilder()
                }
            }
        case .smallImage(let imageName):
            Button(action: {
                action()
            }) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }

        }
    }
}
