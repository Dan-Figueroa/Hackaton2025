//
//  SearchBarComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 14/03/25.
//

import SwiftUI

struct SearchBarComponent: View {
    @State private var searchText: String = ""

    var body: some View {
        HStack(spacing: 0) {
            TextField("Buscar...", text: $searchText)
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.beige)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .autocorrectionDisabled(true)

            ZStack {
                Button(action: {
                    print("Buscando: \(searchText)")
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding(25)
                }

                Rectangle()
                    .foregroundColor(.arena)
                    .frame(width: 30, height: 65)
                    .offset(x: -45)
            }
        }
        .padding(.horizontal, 10)
        .background(Color.arena)
        .cornerRadius(30)
        .padding(.horizontal)
        .shadow(color: .gray, radius: 5, y: 3)
    }
}

#Preview {
    SearchBarComponent()
}
