//
//  InformateView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import SwiftUI

struct InformateView: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            // Fondo
            Background()
            
            // Contenido (logo y mapa)
            VStack {
                RaivaLogo(size: .large)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()

                MapComponent(mapaType: .noPointed, isFinding: true)
                
                Spacer()
            }
            .offset(x: -280, y: 70)
            
            HStack {
                Button {
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color.beige)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .offset(y: 32) // Ajusta la posición vertical del botón
        }
    }
}

#Preview {
    InformateView(presentSideMenu: .constant(false))
        .environmentObject(AppData())
}
