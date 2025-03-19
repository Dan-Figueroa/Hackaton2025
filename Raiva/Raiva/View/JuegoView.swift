//
//  JuegoView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import SwiftUI

struct JuegoView: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "line.horizontal.3")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color.beige)
                }
                    Spacer()
                }
            Spacer()
            Text("JuegoView")
            Spacer()
        }
            .padding(.horizontal, 24)
    }
}
