//
//  Principal.swift
//  Raiva
//
//  Created by Dan Figueroa on 13/03/25.
//

import SwiftUI

struct Principal: View {
    @StateObject var appData = AppData()
    
    var body: some View {
        ZStack {
            Background()
            VStack{
                HStack {
                    RaivaLogo(size: .large)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Spacer()
                Button(action: {
                    print("Mapa presionado")
                }) {
                    MapComponent(mapaType: .points, isFinding: true)
                        
                }
                Spacer()
            }
        }
    }
}

#Preview {
    Principal()
        .environmentObject(AppData())
}
