//
//  LocationComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 20/03/25.
//

import SwiftUI

import SwiftUI

struct LocationComponent: View {
    
    enum State {
        case rojo
        case verde
    }
    
    let state: State
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            switch state {
            case .rojo:
                Image("location")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
            case .verde:
                Image("locationGreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
    }
}

#Preview {
    VStack {
        LocationComponent(state: .rojo, action: {
            print("Botón normal presionado")
        })
    }
}
