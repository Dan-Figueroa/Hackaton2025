//
//  Empecemos.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//

import SwiftUI

struct Empecemos: View {
    var body: some View {
        ZStack(alignment: .center) {
            CardContainer(width: 700, height: 170, color: .arena)
        
            CardContainer(width: 660, height: 140, color: .beige, strokeColor: .brown) {
                Text("¡Pon a prueba tus conocimientos y sube hasta la cima del Palo Ensebado! 🌿")
                    .frame(width: 560)
                    .font(.custom("Gagalin", size: 25))
                    .multilineTextAlignment(.center)
            }
        
            VStack {
                CardContainer(width: 400, height: 60, color: .arena)
                Spacer().frame(height: 95)
            }
            .offset(y: -30)
            
         
            CardContainer(width: 360, height: 40, color: .beige, strokeColor: .brown) {
                HStack(spacing: 80) {
                    GrayRectangle()
                    Text("Empecemos")
                        .font(.custom("Gagalin", size: 25))
                    GrayRectangle()
                }
            }
            .offset(y: -76)
        }
        .frame(height: 170)
    }
  
    private func CardContainer(
        width: CGFloat,
        height: CGFloat,
        color: Color,
        strokeColor: Color? = nil,
        @ViewBuilder content: () -> some View = { EmptyView() }
    ) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: width, height: height)
            .foregroundColor(color)
            .overlay(
                Group {
                    if let strokeColor = strokeColor {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(strokeColor, lineWidth: 2)
                    }
                }
            )
            .overlay(content())
    }
   
    private func GrayRectangle() -> some View {
        Rectangle()
            .frame(width: 20, height: 10)
            .foregroundColor(.gray)
            .cornerRadius(10)
    }
}

#Preview {
    Empecemos()
}
