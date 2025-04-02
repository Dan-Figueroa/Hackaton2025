//
//  Filtro.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//

import SwiftUI

struct Filtro: View {
    var opciones: [String]
    var onSeleccion: (String) -> Void

    @State private var opcionSeleccionada: String?
    
    var body: some View {
        Rectangle()
            .frame(width: 300, height: 300)
            .cornerRadius(30)
            .foregroundColor(.beige)
            .overlay(
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(opciones, id: \.self) { opcion in
                            Button(action: {
                                opcionSeleccionada = opcion
                                print("Opción seleccionada: \(opcion)")
                                onSeleccion(opcion)
                            }) {
                                Text(opcion)
                                    .font(.custom("Gagalin", size: 30))
                                    .frame(maxWidth: .infinity, minHeight: 44)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom,5)
                                    .foregroundColor(.verdeBosque)
                                    .bold()
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(20)
                }
                .frame(width: 280, height: 280)
            )
    }
}

#Preview {
    Filtro(opciones: ["Todas", "Populares", "Más recientes", "Más antiguas"]) { opcion in
        print("Se seleccionó: \(opcion)")
    }
}
