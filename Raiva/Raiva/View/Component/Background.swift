//
//  Background.swift
//  Raiva
//
//  Created by Jesus Ortega on 18/03/25.
//

import SwiftUI

struct Background: View { // RaivaBackground with logo
    var body: some View {
        ZStack{
            Image("fondo")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: .infinity, height: .infinity)
        }
    }
}

#Preview {
    Background()
}
