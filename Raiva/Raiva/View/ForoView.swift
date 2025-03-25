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

    var body: some View {
        ZStack(alignment: .topLeading) {
            Background()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 110) {
                Button {
                    selectedSideMenuTab = 0
                } label: {
                    RaivaLogo(size: .medium)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.top, -10)
                SideMenuButtonsComponent(selectedButton: $selectedButton)

            }
            .frame(width: 270, height: 809, alignment: .leading)
            .background(Color.verdeBosque.opacity(0.8))
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}

#Preview {
    ForoView(presentSideMenu: .constant(false), selectedSideMenuTab: .constant(1))
        .environmentObject(AppData())
}
