//
//  Background.swift
//  Raiva
//
//  Created by Jesus Ortega on 18/03/25.
//

import SwiftUI

struct Background: View {
    var imageName: String
    var body: some View {
        ZStack{
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: .infinity, height: .infinity)
        }
    }
}

#Preview {
    Background(imageName: "fondo")
}
