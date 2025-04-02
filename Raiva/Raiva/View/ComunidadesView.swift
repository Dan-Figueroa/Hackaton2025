//
//  ComunidadesView.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//

import SwiftUI

struct ComunidadesView: View {
    @Binding var showCreateComunity: Bool
    @State private var showFilter = false
    @State private var filterOpacity = 0.0

    let opcionesFiltro = ["Todas", "Populares", "Más recientes", "Más antiguas"]

    var body: some View {
        ZStack {
            VStack {
                HeadComponent(
                    filterAction: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showFilter = true
                            filterOpacity = 1.0
                        }
                    },
                    createAction: {
                        showCreateComunity = true
                    }
                )
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                Rectangle()
                    .frame(width: 1100, height: 700)
                    .foregroundColor(.verdeBosque.opacity(0.6))
                    .cornerRadius(20)
            }
            
            if showFilter {
                Filtro(opciones: opcionesFiltro) { opcion in
                    print("Se seleccionó: \(opcion)")
                    withAnimation(.easeInOut(duration: 0.3)) {
                        filterOpacity = 0.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showFilter = false
                    }
                }
                .opacity(filterOpacity)
                .offset(x: -400, y: -180) 
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        filterOpacity = 1.0
                    }
                }
                .zIndex(2)
            }
        }
    }
}

#Preview {
    ComunidadesView(showCreateComunity: .constant(false))
}
