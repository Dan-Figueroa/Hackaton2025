//
//  InicioView.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import SwiftUI

struct InicioView: View {
    @Binding var showCreateComunity: Bool
    
    var body: some View {
        VStack {
            HeadComponent(
                filterAction: {
                    print("Filtrar presionado")
                },
                createAction: {
                    showCreateComunity = true
                }
            )
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(0..<10, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.verdeBosque)
                            .frame(width: 1100, height: 150)
                            .cornerRadius(10)
                    }
                }
                .padding()
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
