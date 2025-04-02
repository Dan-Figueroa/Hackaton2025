//
//  ComunidadesView.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//

import SwiftUI

struct ComunidadesView: View {
    @Binding var showCreateComunity: Bool
    @StateObject private var filtroViewModel = FiltroViewModel()
    let opcionesFiltro = ["Todas", "Populares", "Más recientes", "Más antiguas"]

    var body: some View {
        VStack {
            HeadComponent(
                filterAction: filtroViewModel.toggleFilter,
                createAction: { showCreateComunity = true }
            )
            .padding(.top, 30)
            .padding(.bottom, 20)

            ZStack {
                Rectangle()
                    .frame(width: 1100, height: 700)
                    .foregroundColor(.verdeBosque.opacity(0.6))
                    .cornerRadius(20)
                
                FiltroOverlay(
                    viewModel: filtroViewModel,
                    opciones: opcionesFiltro,
                    onSeleccion: { print("Filtro aplicado: \($0)") },
                    offsetX: -280, offsetY: -310
                )
            }
        }
    }
}

#Preview {
    ComunidadesView(showCreateComunity: .constant(false))
}
