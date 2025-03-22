//
//  ForoView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//
import SwiftUI

struct ForoView: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack {
                Background()
            }
            MenuButton(presentSideMenu: $presentSideMenu)
        
        }
    }
}
