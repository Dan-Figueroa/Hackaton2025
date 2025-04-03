//
//  GanadorView.swift
//  Raiva
//
//  Created by Dan Figueroa on 03/04/25.
//

import SwiftUI

struct GanadorView: View {
    let ganador: String
    let action: () -> Void
    let action2: () -> Void
    @Environment(\.dismiss) private var dismiss
    @StateObject private var audioPlayer = AudioPlayer()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            Image("ganador")
                .scaleEffect(1.2)
            
            Text(ganador)
                .font(.custom("Gagalin", size: 40))
                .foregroundColor(.white)
                .padding(.top, 500)
            
            HStack {
                CustomButton(action: {
                    // 1. Sonido al presionar el botón
                    audioPlayer.playSound(named: "sonidoBajarPalo", loop: false)
                    
                    
                    
                    // Ejecutar la acción
                    action()
                }, style: .standard(fontColor: .blanco, backgroundColor: .green, buttonName: "Jugar de nuevo"))
                .frame(width: 200)
                
                CustomButton(action: {
                    // Sonido al presionar el botón
                    audioPlayer.playSound(named: "popBotones", loop: false)
    
                        action2()
                        dismiss()
                    
                }, style: .standard(fontColor: .blanco, backgroundColor: .rojo, buttonName: "Salir"))
                .frame(width: 200)
            }
            .padding(.top, 700)
        }
        .onAppear {
            
            audioPlayer.playSound(named: "ganador", loop: false)
        }
        .onDisappear {
           
            audioPlayer.stopSound()
        }
    }
}
    struct GanadorView_Previews: PreviewProvider {
        static var previews: some View {
            GanadorView(ganador: "Jugador Izquierdo", action: {},action2: {})
        }
    }
