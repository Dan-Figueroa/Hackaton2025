//
//  ModelosView.swift
//  Raiva
//
//  Created by Jesus Ortega on 03/04/25.
//

import SwiftUI

struct ModelosView: View {
    var body: some View {
        ZStack{
            
            ARViewContainer(etnia: .chol) 
            
            
            VStack {
                CustomButton(action: {
                    
                }, style: .standard(fontColor: .beige, backgroundColor: .verdeBosque, buttonName: "SALIR"))
            }.padding(.top,700)
                .frame(width: 400)
        }.edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ModelosView()
}
