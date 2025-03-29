//
//  SearchBarComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 14/03/25.
//

import SwiftUI

struct SearchBarComponent: View {
    @State private var searchText: String = ""
    var compactMode: Bool = false
    
    // Valores adaptables
    private var textFieldPadding: CGFloat {
        compactMode ? 10 : 20
    }
    
    private var iconSize: CGFloat {
        compactMode ? 20 : 30
    }
    
    private var buttonPadding: CGFloat {
        compactMode ? 15 : 25
    }
    
    private var barHeight: CGFloat {
        compactMode ? 45 : 65
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TextField("Buscar...", text: $searchText)
                .padding(.vertical, textFieldPadding)
                .padding(.horizontal, textFieldPadding)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.beige)
                .clipShape(RoundedRectangle(cornerRadius: compactMode ? 15 : 20))
                .autocorrectionDisabled(true)
                .font(.system(size: compactMode ? 14 : 16))

            ZStack {
                Rectangle()
                    .foregroundColor(.arena)
                    .frame(width: iconSize, height: barHeight)
                    .offset(x: -iconSize * 1.5)
                
                Button(action: {
                    print("Buscando: \(searchText)")
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(.white)
                        .padding(buttonPadding)
                }
            }
        }
        .padding(.horizontal, compactMode ? 8 : 10)
        .background(Color.arena)
        .cornerRadius(compactMode ? 20 : 30)
        .padding(.horizontal)
        .shadow(color: .gray, radius: compactMode ? 3 : 5, y: compactMode ? 2 : 3)
        .frame(height: barHeight)
    }
}

#Preview {
    SearchBarComponent()
}
