//
//  MainTabbedView..swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import SwiftUI

struct MainTabbedView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack {
            // Mostrar solo la vista seleccionada
            Group {
                switch selectedSideMenuTab {
                case 0:
                    ForoView(presentSideMenu: $presentSideMenu)
                case 1:
                    InformateView(presentSideMenu: $presentSideMenu)
                case 2:
                    JuegoView(presentSideMenu: $presentSideMenu)
                default:
                    EmptyView()
                }
            }
            
            // Menú lateral
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbedView()
            .environmentObject(AppData())
    }
}
