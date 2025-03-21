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
            }
            .padding(.horizontal, 24)
            .offset(y: 32)
        }
    }
}
