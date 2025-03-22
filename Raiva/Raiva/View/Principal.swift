//
//  Principal.swift
//  Raiva
//
//  Created by Dan Figueroa on 13/03/25.
//
import SwiftUI

struct Principal: View {
    @StateObject var appData = AppData()
    @Binding var presentSideMenu: Bool
    @Binding var selectedSideMenuTab: Int
    @State private var moveLeft = false
    @State private var moveDown = false

    var body: some View {
        ZStack {
            Background()
                .ignoresSafeArea()
            ZStack(alignment: .top) {
                VStack {
                    RaivaLogo(size: .large)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(
                            x: moveDown ? -280 : 0,
                            y: moveDown ? 70 : 0
                        )
                        .animation(.easeInOut(duration: 0.5), value: moveDown)
                    
                    Spacer()

                    Button(action: {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            moveDown = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            selectedSideMenuTab = 2
                        }
                    }) {
                        MapComponent(mapaType: .points, isFinding: true)
                            .offset(
                                x: moveDown ? -280 : 0,
                                y: moveDown ? 70 : 0
                            )
                            .animation(.easeInOut(duration: 0.5), value: moveDown)
                    }
                    
                    Spacer()
                }
                HStack {
                    Button {
                        presentSideMenu.toggle()
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color.beige)
                    }

                    Spacer()

                    Button {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            moveLeft = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            selectedSideMenuTab = 1
                        }
                    } label: {
                        Image("mensajes")
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                }
                .padding(.horizontal, 24)
                .offset(y: -20)
            }
            .offset(x: moveLeft ? -UIScreen.main.bounds.width : 0) 
            .animation(.easeInOut(duration: 0.5), value: moveLeft)
        }
    }
}

#Preview {
    Principal(presentSideMenu: .constant(false), selectedSideMenuTab: .constant(0))
        .environmentObject(AppData())
}
