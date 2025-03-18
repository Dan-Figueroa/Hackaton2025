//
//  ContentView.swift
//  Raiva
//
//  Created by Jesus Ortega on 13/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ARViewModel()
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.custom("Gagalin", size:48))
                .foregroundColor(Color.beige)
            ARViewContainer(viewModel: viewModel)
                        .edgesIgnoringSafeArea(.all)
            
                
        }.ignoresSafeArea(.all)
        .background(Color.verdeBosque)
        .padding()
    }
}

#Preview {
    ContentView()
}
