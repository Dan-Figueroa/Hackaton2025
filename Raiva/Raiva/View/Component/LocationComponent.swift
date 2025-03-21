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
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            switch state {
            case .rojo:
                Image("location")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            case .verde:
                Image("locationGreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            }
        }
    }
}

#Preview {
    VStack {
        LocationComponent(state: .verde, action: {
            print("Botón normal presionado")
        })
    }
}
