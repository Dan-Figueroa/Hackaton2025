//
//  ContentView.swift
//  Raiva
//
//  Created by Jesus Ortega on 13/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ARViewContainer(etnia: .chol) // Cambia la etnia aquí
                
        }.edgesIgnoringSafeArea(.all)
    }
}
#Preview {
    ContentView()
}
