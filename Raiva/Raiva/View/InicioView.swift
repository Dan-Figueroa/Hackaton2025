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
    @StateObject private var forumDisplayViewModel = ForumDisplayViewModel()
    @StateObject private var filtroViewModel = FiltroViewModel()
    @Binding var showCreateComunity: Bool
    @State var count: Int = 0
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
                    ForEach(Array(forumDisplayViewModel.forums.enumerated()), id: \.element.id) { index, forum in
                        if let displayData = forumDisplayViewModel.getForumDisplayData(for: forum) {
                            ZStack {
                                ForumComponent(
                                    communityData: displayData.community,
                                    userData: displayData.user,
                                    forumData: forum,
                                    withBackground: true
                                )
                                
                                Text("\(index + 1)")
                                    .font(.custom("futura", size: 50))
                                    .foregroundStyle(.red)
                            }
                        }

                    }
                }
                .padding()
            }
        }
        
        FiltroOverlay(
            viewModel: filtroViewModel,
            opciones: opcionesFiltro,
            onSeleccion: { print("Filtro aplicado: \($0)") },
            offsetX: -270, offsetY: -560
        )
    }
}

    #Preview {
        ForoView(
            presentSideMenu: .constant(false),
            selectedSideMenuTab: .constant(1)
        )
        .environmentObject(AppData())
    }
