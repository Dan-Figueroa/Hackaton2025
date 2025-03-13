//
//  ContentView.swift
//  Raiva
//
//  Created by Jesus Ortega on 13/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.custom("Gagalin", size:48))
                .foregroundColor(Color.beige)
            
                
        }.background(Color.verdeBosque)
        .padding()
    }
}

#Preview {
    ContentView()
}
