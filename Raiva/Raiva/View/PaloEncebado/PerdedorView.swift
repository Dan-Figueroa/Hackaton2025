//
//  PerdedorView.swift
//  Raiva
//
//  Created by Dan Figueroa on 03/04/25.
//

import SwiftUI

struct PerdedorView: View {
    let ganador: String
    let action: () -> Void
    let action2: () -> Void
    @Environment(\.dismiss) private var dismiss
    @StateObject private var audioPlayer = AudioPlayer()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            Image("perdedor")
                .scaleEffect(1.1)
                .padding(.top,-100)
           
            Text(ganador)
                .font(.custom("Gagalin", size: 40))
                .foregroundColor(.white)
                .padding(.top, 500)
            
            HStack {
                CustomButton(action: {
                    audioPlayer.playSound(named: "sonidoBajarPalo", loop: false)
                    action()
                }, style: .standard(fontColor: .blanco, backgroundColor: .green, buttonName: "Jugar de nuevo"))
                .frame(width: 200)
                
                CustomButton(action: {
                    audioPlayer.playSound(named: "popBotones", loop: false)
                    action2()
                }, style: .standard(fontColor: .blanco, backgroundColor: .rojo, buttonName: "Salir"))
                .frame(width: 200)
            }
            .padding(.top, 700)
        }
        .onAppear {
            audioPlayer.playSound(named: "perdedor", loop: false)
        }
        .onDisappear {
            audioPlayer.stopSound()
        }
    }
}

struct PerdedorView_Previews: PreviewProvider {
    static var previews: some View {
        PerdedorView(ganador: "Jugador Derecho", action: {}, action2: {})
    }
}
