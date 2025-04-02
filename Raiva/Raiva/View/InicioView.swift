//
//  InicioView.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import SwiftUI

struct InicioView: View {
    @Binding var showAltaForo: Bool
    @StateObject private var foroViewModel = ForumViewModel()
    @StateObject private var filtroViewModel = FiltroViewModel()

    let opcionesFiltro = ["Todas", "Mas relevantes", "Más recientes", "Más antiguas"]
    
    var body: some View {
        VStack {
            HeadComponent(
                filterAction: filtroViewModel.toggleFilter,
                createAction: { showAltaForo = true }
            )
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(foroViewModel.forums, id: \ .self) { forum in
                        // ForumComponent(communityData: <#T##Community#>, userData: <#T##User#>, forumData: <#T##Forum#>, withBackground: <#T##Bool#>)
                    }
                }
                .padding()
            }
            
            FiltroOverlay(
                viewModel: filtroViewModel,
                opciones: opcionesFiltro,
                onSeleccion: { print("Filtro aplicado: \($0)") },
                offsetX: -270, offsetY: -560
            )
        }
    }
}
#Preview {
    ForoView(
        presentSideMenu: .constant(false),
        selectedSideMenuTab: .constant(1)
    )
    .environmentObject(AppData())
}
