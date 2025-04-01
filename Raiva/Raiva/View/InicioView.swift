//
//  InicioView.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import SwiftUI

struct InicioView: View {
    @State private var showCreateComunity = false
    var body: some View {
        VStack {
            
            HeadComponent(
                filterAction: {
                    print("Filtrar presionado")
                },
                createAction: {
                    showCreateComunity.toggle()
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
        if showCreateComunity {
            Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                showCreateComunity = false
            }
            CreateComunity()
            .transition(.scale.combined(with: .opacity))
            .zIndex(1)
        }
    }
}

#Preview {
    InicioView()
}
