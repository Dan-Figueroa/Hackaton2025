//
//  HeadComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import SwiftUI

struct HeadComponent: View {
    let filterAction: () -> Void
    let createAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            CustomButton(action: filterAction, style: .image(imageName: "filtrar"))
            
            Spacer()
            
            SearchBarComponent()
                .scaleEffect(0.6)
                .frame(width: 550, height: 0)
                .padding(.trailing, -100)
 
            HStack{
                Image("crear")
                    .resizable()
                    .frame(width: 40, height: 40)
                CustomButton(action: createAction,
                           style: .standard(fontColor: .beige,
                                         backgroundColor: .clear,
                                         buttonName: "Crear"))
                .frame(width: 77, height:40)
                
            }.frame(width: 130, height:50 )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.beige, lineWidth: 2)
            )
        }
        .padding(.horizontal, 20)
        .frame(height: 60)
    }
}
#Preview {
    HeadComponent(
        filterAction: {
            print("Filtrar presionado")
        },
        createAction: {
            print("Crear presionado")
        }
    )
}
