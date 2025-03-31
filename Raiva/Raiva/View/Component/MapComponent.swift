//
//  MapComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 18/03/25.
//

import SwiftUI

struct MapComponent: View {
    @EnvironmentObject var appData: AppData
    let mapaType: MapaType
    var isFinding: Bool
    var body: some View {
        ZStack {
            if (isFinding){
                Finding() // Circulos
            }
            Image(mapaType.getMapaType())
                .padding(.leading, 100)
        }.frame(maxWidth: .infinity)
            
    }
}

enum MapaType{
    case points, noPointed
    
    func getMapaType() -> String {
        switch self {
        case .points:
            return "Mapa"
        case .noPointed:
            return "mapaBlanco"
        }
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
    MapComponent(mapaType: .noPointed, isFinding: true)
        .environmentObject(AppData())
}
