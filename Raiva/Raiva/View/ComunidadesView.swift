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
                    .frame(maxWidth: .infinity, maxHeight: 700)
                    .foregroundColor(.verdeBosque.opacity(0.6))
                    .cornerRadius(20)
                    .overlay{
                            ListaComunidades()
                    }
                
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

struct ListaComunidades: View {
    @State private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    @StateObject private var filtroViewModel = FiltroViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(filtroViewModel.communities, id: \.self) { comunidades in
                    
                    Button {
                        print("goa")
                    } label: {
                        UserViewType(imageName: comunidades.communityProfileImage, name: comunidades.communityName, style: .horizontal)
                    }.frame(width: 300, height: 230)

                    
                    
                        
                }
            }
            .padding()
        }
    }
}

#Preview {
    ComunidadesView(showCreateComunity: .constant(false))
}
