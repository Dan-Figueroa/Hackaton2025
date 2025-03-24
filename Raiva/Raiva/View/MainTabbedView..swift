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
            Group {
                switch selectedSideMenuTab {
                case 0:
                    Principal(presentSideMenu: $presentSideMenu, selectedSideMenuTab: $selectedSideMenuTab)
                case 1:
                    ForoView(presentSideMenu: $presentSideMenu, selectedSideMenuTab: $selectedSideMenuTab)
                case 2:
                    InformateView(presentSideMenu: $presentSideMenu)
                case 3:
                    JuegoView(presentSideMenu: $presentSideMenu)
                default:
                    EmptyView()
                }
            }
            
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
