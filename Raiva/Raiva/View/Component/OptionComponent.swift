//
//  OptionComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//

import SwiftUI

struct OptionComponent: View {
    enum OptionSet {
        case basic
        case extended
        case relevantes
        case community
        case custom
    }
    
    @State private var selectedItem: String?
    let optionSet: OptionSet
    var frameWidth: CGFloat = 300
    var frameHeight: CGFloat = 300
    
    private var items: [String] {
        switch optionSet {
        case .basic:
            return ["Todas", "Más recientes"]
        case .extended:
            return ["Todas", "Populares", "Más recientes", "Antiguas"]
        case .relevantes:
            return ["Todas", "Más relevantes", "Más recientes", "Más antiguas"]
        case .community:
            return ["Publicación", "Nueva comunidad"]
        case .custom:
            return ["Favoritas", "Recomendadas"]
        }
    }
    
    init(optionSet: OptionSet = .basic, frameWidth: CGFloat = 300, frameHeight: CGFloat = 300) {
        self.optionSet = optionSet
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color.beige)
            .frame(width: frameWidth, height: frameHeight)
            .cornerRadius(20)
            .overlay(
                VStack(spacing: 5) {
                    ForEach(items, id: \.self) { item in
                        optionRow(for: item)
                    }
                    Spacer()
                }
                .padding(.top, 12)
            )
    }
    
    private func optionRow(for item: String) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                CustomButton(
                    action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedItem = item
                        }
                    },
                    style: .standard(
                        fontColor: .verdeBosque,
                        backgroundColor: .clear,
                        buttonName: item
                    )
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 15)
                
                if selectedItem == item {
                    Image(systemName: "checkmark")
                        .foregroundColor(.verdeBosque)
                        .transition(.opacity.combined(with: .scale))
                        .padding(.trailing, 15)
                } else {
                    Spacer()
                        .frame(width: 20)
                }
            }
            .frame(height: 44)
            
            if item != items.last {
                Divider()
                    .frame(width: frameWidth)
                    .overlay(Color.verdeBosque.opacity(0.15))
                    .padding(.top, 8)
            }
        }
    }
}

#Preview {
    OptionComponent(optionSet: .custom, frameHeight: 120)
}
