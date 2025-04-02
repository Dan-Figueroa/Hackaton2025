//
//  InicioView.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import SwiftUI

struct InicioView: View {
    @Binding var showCreateComunity: Bool
    @StateObject var foroViewModel = ForumViewModel()
    
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
                    ForEach(foroViewModel.forums, id: \.self) { forum in
//                        ForumComponent(communityData: <#T##Community#>, userData: <#T##User#>, forumData: <#T##Forum#>, withBackground: <#T##Bool#>)
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
