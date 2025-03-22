//
//  InformateView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import SwiftUI

struct InformateView: View {
    @Binding var presentSideMenu: Bool
    @State private var selectedEtnia: EtniasEnum? = .zoque
    
    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            VStack {
                RaivaLogo(size: .large)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                MapWithLocations(selectedEtnia: $selectedEtnia)
                
                Spacer()
            }
            .offset(x: -280, y: 70)

            MenuButton(presentSideMenu: $presentSideMenu)

            VStack(spacing: 50) {
            
                Rectangle()
                    .overlay(
                        Text(selectedEtnia?.rawValue.uppercased() ?? "SELECCIONA UNA ETNIA")
                            .font(.custom("Gagalin", size: 70))
                            .foregroundStyle(Color.beige)
                    )
                    .foregroundColor(Color.verdeBosque)
                    .frame(width: 400, height: 100)
                    .cornerRadius(30)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        if let infoEtnia = getInfoEtnia(selectedEtnia: selectedEtnia) {
                            InfoRectangle(
                                title: "POBLACIÓN",
                                subtitle: "\(infoEtnia.poblacion)",
                                imageName: infoEtnia.poblacionImage
                            )
                            
                            // Rectángulo de Platillo Típico
                            InfoRectangle(
                                title: "PLATILLO TÍPICO",
                                subtitle: infoEtnia.platillo.first ?? "",
                                imageName: infoEtnia.platillo.last ?? ""
                            )
                            
                            // Rectángulo de Vestimenta
                            InfoRectangle(
                                title: "VESTIMENTA",
                                subtitle: "",
                                imageName: infoEtnia.vestimenta
                            )
                            
                            // Rectángulo de Festividad
                            InfoRectangle(
                                title: "FESTIVIDAD",
                                subtitle: infoEtnia.festividad.first ?? "",
                                imageName: infoEtnia.festividad.last ?? ""
                            )
                        }
                    }
                }
                .frame(width: 450, height: 400)
                
                // Botón de simulación
                CustomButton(action: {}, fontColor: .beige, backgroundColor: .verdeBosque, buttonName: "simulacion")
                    .frame(width: 200)
            }
            .padding()
            .offset(x: 350, y: 100)
        }
    }
    

    private func getInfoEtnia(selectedEtnia: EtniasEnum?) -> InfoEtnia? {
        return infoEtnias.first { $0.etnia == selectedEtnia }
    }
}

#Preview {
    InformateView(presentSideMenu: .constant(false))
        .environmentObject(AppData())
}
