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
                    Spacer()
                    Image(systemName: "message.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: appData.UISH * 0.1)
                        .padding(20)
                }
                Spacer()
                Button(action: {
                    print("Mapa presionado")
                }) {
                    MapComponent(isFinding: true)
                        
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
