//
//  ModelosView.swift
//  Raiva
//
//  Created by Jesus Ortega on 03/04/25.
//

import SwiftUI

struct ModelosView: View {
    let selectedEtnia: EtniasEnum 
        @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ARViewContainer(etnia: selectedEtnia)

            VStack {
                Spacer()
                
                CustomButton(
                    action: {
                        dismiss()
                    },
                    style: .standard(
                        fontColor: .beige,
                        backgroundColor: .verdeBosque,
                        buttonName: "SALIR"
                    )
                ).frame(width: 300)
                .padding(.bottom, 40)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ModelosView(selectedEtnia: .chol)
}
