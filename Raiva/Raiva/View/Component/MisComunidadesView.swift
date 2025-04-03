//
//  MisComunidadesView.swift
//  Raiva
//
//  Created by Dan Figueroa on 28/03/25.
//
import SwiftUI

struct MisComunidadesView: View {
    @Binding var isPresented: Bool
    @State private var showTwoColumns = false
    @State private var showComponent = false
    @State private var arrowImageName: String = "flecha"
    @StateObject private var filtroViewModel = FiltroViewModel()
    @StateObject private var comunidadesVM = MisComunidadesViewModel()
    
    let opcionesFiltro = ["Todas", "Más recientes"]
    var dynamicWidth: CGFloat {
        showTwoColumns ? 500 : 300
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image(systemName: "triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 50)
                .rotationEffect(.degrees(-90))
                .foregroundColor(Color.verdeBosque)
                .offset(x: -19, y: 20)
            
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        CustomButton(action: filtroViewModel.toggleFilter, style: .image(imageName: "filtrar"))
                        Spacer()
                        CustomButton(action: {
                            withAnimation(.spring()) {
                                showComponent.toggle()
                                showTwoColumns.toggle()
                                arrowImageName = showTwoColumns ? "flechaAlrevez" : "flecha"
                            }
                        }, style: .smallImage(imageName: arrowImageName))
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 12)
                    
                    if showComponent {
                        SearchBarComponent()
                            .scaleEffect(0.7)
                            .frame(width: 450, height: 30)
                            .transition(.opacity)
                    }
                }
                .frame(height: 90)
                
                ScrollView {
                    if showTwoColumns {
                        LazyVGrid(
                            columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)],
                            spacing: 20
                        ) {
                            ForEach(comunidadesVM.getCommunitiesForUser(userID: CurrentUser.shared.id), id: \.id) { community in
                                CommunityForumComponent(
                                    communityName: community.communityName,
                                    communityIcon: community.communityProfileImage
                                )
                                .frame(width: 200, height: 100)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 12)
                            }
                        }
                        .padding(.horizontal, 16)
                    } else {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(comunidadesVM.getCommunitiesForUser(userID: CurrentUser.shared.id), id: \.id) { community in
                                CommunityForumComponent(
                                    communityName: community.communityName,
                                    communityIcon: community.communityProfileImage
                                )
                                .frame(width: 250, height: 100)
                                .padding(.vertical, 12)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .frame(width: dynamicWidth, height: 600)
            .background(Color.verdeBosque)
            .animation(.easeInOut, value: showTwoColumns)
            
            FiltroOverlay(
                viewModel: filtroViewModel,
                opciones: opcionesFiltro,
                onSeleccion: { print("Filtro aplicado: \($0)") },
                offsetX: 10, offsetY: -150
            )
        }
        .onAppear {
            comunidadesVM.loadInitialData()
        }
    }
}

#Preview {
    MisComunidadesView(isPresented: .constant(true))
}

