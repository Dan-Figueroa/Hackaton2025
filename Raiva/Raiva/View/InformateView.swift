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
    @State private var showModels = false
    @StateObject private var audioPlayer = AudioPlayer()
    
    var body: some View {
        ZStack(alignment: .top) {
            Background(imageName: "fondo")
            
            VStack {
                RaivaLogo(size: .large)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                MapWithLocations(selectedEtnia: $selectedEtnia)
                
                Spacer()
            }
            .offset(x: -280, y: 70)
            .onChange(of: selectedEtnia) { _, _ in
                audioPlayer.stopSound()
            }

            MenuButton(presentSideMenu: $presentSideMenu)

            VStack(spacing: 50) {
                Rectangle()
                    .overlay(
                        HStack(spacing:30){
                            Text(selectedEtnia?.rawValue.uppercased() ?? "SELECCIONA UNA ETNIA")
                                .font(.custom("Gagalin", size: 50))
                                .foregroundStyle(Color.beige)
                            
                            if let selectedEtnia = selectedEtnia,
                               let infoEtnia = getInfoEtnia(selectedEtnia: selectedEtnia) {
                                CustomButton(action: {
                                    audioPlayer.stopSound()
                                    audioPlayer.playSound(named: infoEtnia.poblacioninfo[1], loop: false)
                                }, style: .image(imageName: "Sonido1"))
                                .scaleEffect(0.6)
                            }
                        }
                    )
                    .foregroundColor(Color.verdeBosque)
                    .frame(width: 400, height: 100)
                    .cornerRadius(30)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        if let infoEtnia = getInfoEtnia(selectedEtnia: selectedEtnia) {
                            createInfoRectangles(for: infoEtnia)
                        }
                    }
                }
                .frame(width: 450, height: 400)
                
                CustomButton(
                    action: {
                        showModels = true
                        
                    },
                    style: .standard(
                        fontColor: .beige,
                        backgroundColor: .verdeBosque,
                        buttonName: "Simulacion"
                    )
                ).frame(width: 200)
            }
            .padding()
            .offset(x: 350, y: 100)
            
            .fullScreenCover(isPresented: $showModels) {
                if let etnia = selectedEtnia {
                    ModelosView(selectedEtnia: etnia)
                }
            }
        }
        .onChange(of: showModels) {_, newValue in
            if !newValue {
                audioPlayer.stopSound()
            }
        }
        
    }
    
    @ViewBuilder
    private func createInfoRectangles(for infoEtnia: InfoEtnia) -> some View {
        InfoRectangle(
            title: "POBLACIÓN",
            subtitle: infoEtnia.poblacion.formatted(),
            imageName: infoEtnia.poblacioninfo[0]
        )
        
        InfoRectangle(
            title: "PLATILLO TÍPICO",
            subtitle: infoEtnia.platillo[0],
            imageName: infoEtnia.platillo[1]
        )
        
        InfoRectangle(
            title: "VESTIMENTA",
            subtitle: "",
            imageName: infoEtnia.vestimenta[0]
        )
        
        InfoRectangle(
            title: "FESTIVIDAD",
            subtitle: infoEtnia.festividad[0],
            imageName: infoEtnia.festividad[1]
        )
    }
    
    private func getInfoEtnia(selectedEtnia: EtniasEnum?) -> InfoEtnia? {
        return infoEtnias.first { $0.etnia == selectedEtnia }
    }
}

#Preview {
    InformateView(presentSideMenu: .constant(false))
        .environmentObject(AppData())
}
