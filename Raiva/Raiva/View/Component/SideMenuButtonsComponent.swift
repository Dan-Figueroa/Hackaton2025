//
//  SideMenuButtonsComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 24/03/25.
//

import SwiftUI

struct SideMenuButtonsComponent: View {
    @Binding var selectedButton: String
    @Binding var showComunidadesSheet: Bool

    let buttons: [(imageName: String, text: String, action: () -> Void)] = [
        ("inicio", "INICIO", { print("Navegando a la pantalla de inicio") }),
        ("misForos", "MIS FOROS", { print("Mostrando mis foros") }),
        ("misComunidades", "MIS COMUNIDADES", {
            
        }),
        ("popular", "POPULAR", { print("Mostrando contenido popular") }),
        ("comunidades", "COMUNIDADES", { print("Explorando todas las comunidades") })
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            ForEach(buttons, id: \.text) { button in
                if button.text == "POPULAR" {
                    Divider()
                        .frame(height: 3)
                        .background(Color.beige)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                }

                CustomButton(
                    action: {
                        selectedButton = button.text
                        if button.text == "MIS COMUNIDADES" {
                            showComunidadesSheet = true
                        }
                        button.action()
                    },
                    style: .imageWithText(
                        imageName: button.imageName,
                        text: button.text,
                        fontColor: .beige,
                        isSelected: selectedButton == button.text
                    )
                )
            }
        }
        .padding(.leading)
    }
}
