//
//  SideMenuButtonsComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 24/03/25.
//

import SwiftUI

struct SideMenuButtonsComponent: View {
    @Binding var selectedButton: String

    let buttons: [(imageName: String, text: String, action: () -> Void)] = [
        ("inicio", "INICIO", { print("Navegando a la pantalla de inicio") }),
        ("misForos", "MIS FOROS", { print("Mostrando mis foros") }),
        ("misComunidades", "MIS COMUNIDADES", { print("Mostrando mis comunidades") }),
        ("popular", "POPULAR", { print("Mostrando contenido popular") }),
        ("comunidades", "COMUNIDADES", { print("Explorando todas las comunidades") })
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(buttons, id: \.text) { button in
                if button.text == "POPULAR" {
                    Divider()
                        .frame(height: 3)
                        .background(Color.beige)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                }

                CustomButtonComponent(
                    imageName: button.imageName,
                    text: button.text,
                    fontColor: .beige,
                    isSelected: selectedButton == button.text,
                    action: {
                        selectedButton = button.text
                        button.action() // Llamamos a la función específica de cada botón
                    }
                )
            }
        }
        .padding(.leading, 20)
    }
}

#Preview {
    SideMenuButtonsComponent(selectedButton: .constant("INICIO"))
}
