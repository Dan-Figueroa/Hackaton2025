//
//  CustomButtonComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 24/03/25.
//

import SwiftUI

struct CustomButtonComponent: View {
    let imageName: String
    let text: String
    let fontColor: Color
    let isSelected: Bool 
    let action: () -> Void
    
    var body: some View {
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
    }
}
