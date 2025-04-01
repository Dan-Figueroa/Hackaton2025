//
//  ForoView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//
import SwiftUI

struct ForoView: View {
    @Binding var presentSideMenu: Bool
    @Binding var selectedSideMenuTab: Int
    @State private var selectedButton: String = "INICIO"
    @State private var showComunidades = false
    @State private var isPresented: Bool = false
    
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
                    
                    SideMenuButtonsComponent(selectedButton: $selectedButton, showComunidadesSheet: $showComunidades)
                }
                .frame(width: 270, height: 809, alignment: .leading)
                .background(Color.verdeBosque.opacity(0.8))
                .edgesIgnoringSafeArea(.vertical)
                
                InicioView()
                    .frame(width: 880, height: 809)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            if showComunidades {
                MisComunidadesView(isPresented: $showComunidades)
                    .offset(x: 300, y: 140)
            }
        }.onAppear{
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
    }
}

#Preview {
    ForoView(
        presentSideMenu: .constant(false),
        selectedSideMenuTab: .constant(1)
    )
    .environmentObject(AppData())
}
