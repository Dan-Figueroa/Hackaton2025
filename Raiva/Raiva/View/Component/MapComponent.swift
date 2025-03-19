//
//  MapComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 18/03/25.
//

import SwiftUI

struct MapComponent: View {
    @EnvironmentObject var appData: AppData
    var isFinding: Bool
    var body: some View {
        ZStack {
            if (isFinding){
                Finding()
            }
            Image("mapa")
        }.frame(maxWidth: .infinity)
            
    }
}

private struct Finding: View {
    @EnvironmentObject var appData: AppData
    @State private var isFinded: Bool = false
    var body: some View {
        ZStack{
            Group{
                Circle()
                    .stroke()
                    .frame(width: 120)
                    .scaleEffect(isFinded ?  1.8 : 1)
                Circle()
                    .stroke()
                    .frame(width: 120)
                    .scaleEffect(isFinded ?  1.4 : 1)
                Circle()
                    .stroke()
                    .frame(width: 120)
                    .scaleEffect(isFinded ?  1.1 : 1)
            }.foregroundStyle(.white)
                .opacity(isFinded ? 0 : 1)
                .animation(
                    .linear(duration: 3)
                    .repeatForever(autoreverses: false), value: isFinded
                )
        }.scaleEffect(appData.UISW/360)
            .onAppear {
                isFinded.toggle()
            }
    }
}



#Preview {
    MapComponent(isFinding: true)
        .environmentObject(AppData())
}
