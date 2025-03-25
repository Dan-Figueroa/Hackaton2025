//
//  SideMenu.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowing: Bool
    var content: AnyView
    
    var body: some View {
        ZStack {
            if isShowing {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isShowing.toggle()
                        }
                    }
            }
            HStack {
                content
                    .frame(width: 270)
                    .background(Color.verdeBosque)
                    .offset(x: isShowing ? 0 : -300)
                    .animation(.easeInOut(duration: 0.5), value: isShowing)

                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}
