//
//  CustomButton.swift
//  Raiva
//
//  Created by Jesus Ortega on 13/03/25.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let fontColor: Color
    let backgroundColor: Color
    let buttonName: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonName)
                .font(.custom("Gagalin", size: 16))
                .foregroundStyle(fontColor)
                .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(backgroundColor, in: .rect(cornerRadius: 20))
            .padding(.horizontal)
    }
}

#Preview {
    CustomButton(action: {}, fontColor: .verdeBosque, backgroundColor: .beige, buttonName: "Raiva")
}
