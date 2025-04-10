//
//  ForoView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//
import SwiftUI

struct ForoView: View {
    @StateObject var ForoViewModel = ForumViewModel()
    @Binding var presentSideMenu: Bool
    @Binding var selectedSideMenuTab: Int
    @State private var selectedButton: String = "INICIO"
    @State private var showComunidades = false
    @State private var isPresented: Bool = false
    @State private var showAltaForo = false
    @State private var showComunidadesView = false
    @State private var showCreateComunity = false
    @StateObject private var registrationCoordinator = RegistrationCoordinator()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Background(imageName: "fondo")
                .ignoresSafeArea()
                .onTapGesture {
                    if showComunidades {
                        withAnimation {
                            showComunidades = false
                        }
                    }
                }
            
            HStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 110) {
                    Button {
                        selectedSideMenuTab = 0
                    } label: {
                        RaivaLogo(size: .medium)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.top, -10)
                    
                    SideMenuButtonsComponent(
                        selectedButton: $selectedButton,
                        showComunidades: $showComunidades,
                        showComunidadesView: $showComunidadesView
                    )
                }
                .frame(width: 270, height: 809, alignment: .leading)
                .background(Color.verdeBosque.opacity(0.8))
                .edgesIgnoringSafeArea(.vertical)
                
                ZStack {
                    Color.clear
                    
                    if showAltaForo {
                        AltaForo(isPresented: $showAltaForo, comunidadSeleccionada: communityData)
                            .frame(width: 880, height: 809)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .transition(.asymmetric(
                                insertion: .opacity.combined(with: .scale(scale: 0.95)),
                                removal: .opacity
                            ))
                    } else if showComunidadesView {
                        if showCreateComunity {
                            CreateComunity(showCreateComunity: $showCreateComunity)
                                .frame(width: 880, height: 809)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .transition(.asymmetric(
                                    insertion: .opacity.combined(with: .scale(scale: 0.95)),
                                    removal: .opacity
                                ))
                        } else {
                            ComunidadesView(showCreateComunity: $showCreateComunity)
                                .frame(width: 800, height: 809)
                                .padding(.trailing, 20)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .transition(.asymmetric(
                                    insertion: .opacity.combined(with: .scale(scale: 0.95)),
                                    removal: .opacity
                                ))
                        }
                    } else {
                        InicioView(showAltaForo: $showAltaForo, showCreateComunity: $showAltaForo)
                            .frame(width: 880, height: 809)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .transition(.opacity)
                    }
                }
                .animation(.spring(duration: 0.4, bounce: 0.1), value: showAltaForo)
                .animation(.spring(duration: 0.4, bounce: 0.1), value: showComunidadesView)
                .animation(.spring(duration: 0.4, bounce: 0.1), value: showCreateComunity)
                .zIndex(1)
            }
            
            if showComunidades {
                MisComunidadesView(isPresented: $showComunidades)
                    .offset(x: 300, y: 140)
            }
        }
        .onAppear {
            if CurrentUser.shared.isLogged != true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isPresented.toggle()
                }
            }
        }
        .sheet(isPresented: $isPresented) {
                    LoginView()
                        .environmentObject(AppData())
                        .presentationBackground(.clear)
                        .interactiveDismissDisabled(true)
                }
        .onChange(of: registrationCoordinator.isRegisterViewPresented) { oldValue, newValue in
            if newValue {
                isPresented = false
            }
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
