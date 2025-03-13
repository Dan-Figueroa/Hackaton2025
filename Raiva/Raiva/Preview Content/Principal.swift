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
            Image("fondo")
                .resizable()
                .scaledToFill()
                .frame(width: appData.UISW*1, height: appData.UISH*1)
                .ignoresSafeArea()
            
            VStack(spacing: 110){
                HStack(spacing: 30){
                    Text("RAIVA")
                    .font(.custom("Gagalin", size: 120))
                    .foregroundColor(Color.beige)
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100 )
                }
                Button(action: {
                    print("Mapa presionado")
                }) {
                    Image("Mapa")
                        .resizable()
                        .frame(width: 500, height: 400)
                }
            }
        }
    }
}

#Preview {
    Principal()
}
