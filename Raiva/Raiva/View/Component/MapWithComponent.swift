//
//  MapWithComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 21/03/25.
//

import SwiftUI

struct MapWithLocations: View {
    @Binding var selectedEtnia: EtniasEnum?
    
    var body: some View {
        ZStack {
            MapComponent(mapaType: .noPointed, isFinding: true)
                .frame(height: 400)
            
            LocationComponent(state: selectedEtnia == .zoque ? .verde : .rojo, action: {
                selectedEtnia = .zoque
            })
            .position(x: 538, y: 148)
            
            LocationComponent(state: selectedEtnia == .tsotsil ? .verde : .rojo, action: {
                selectedEtnia = .tsotsil
            })
            .position(x: 572, y: 202)
            
            LocationComponent(state: selectedEtnia == .chol ? .verde : .rojo, action: {
                selectedEtnia = .chol
            })
            .position(x: 688, y: 151)
            
            LocationComponent(state: selectedEtnia == .tojolabal ? .verde : .rojo, action: {
                selectedEtnia = .tojolabal
            })
            .position(x: 679, y: 233)
            
            LocationComponent(state: selectedEtnia == .tseltal ? .verde : .rojo, action: {
                selectedEtnia = .tseltal
            })
            .position(x: 745, y: 210)
            
            LocationComponent(state: selectedEtnia == .chuj ? .verde : .rojo, action: {
                selectedEtnia = .chuj
            })
            .position(x: 746, y: 316)
            
            LocationComponent(state: selectedEtnia == .qanjobal ? .verde : .rojo, action: {
                selectedEtnia = .qanjobal
            })
            .position(x: 832, y: 290)
            
            LocationComponent(state: selectedEtnia == .mam ? .verde : .rojo, action: {
                selectedEtnia = .mam
            })
            .position(x: 654, y: 422)
        }
    }
}
