//
//  InstruccionesView.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import SwiftUI

struct InstruccionesView: View {
    @Binding var presentSideMenu: Bool
    @Environment(\.dismiss) var dismiss
    @StateObject private var audioPlayer = AudioPlayer()
    
    var body: some View {
        ZStack(alignment: .center) {
            Background(imageName: "fondoPES")

            Rectangle()
                .frame(width: 1100, height: 750)
                .cornerRadius(40)
                .opacity(0.3)
            
            HStack {
                CustomButton(action: {
                    audioPlayer.playSound(named: "popBotones", loop: false)
                    dismiss()
                }, style: .image(imageName: "regresar"))
                .padding(.leading, -23)
                Spacer()
                
                Image("instrucciones")
                    .padding(.leading, 200)
             
                Spacer()
                Image("logoPE")
                    .resizable()
                    .frame(width: 250, height: 100)
                    .padding(.trailing, -3)
            }
            .frame(width: 1100)
            .padding(.bottom, 50)
            .offset(y: -300)
            
            VStack(alignment: .leading, spacing: 20){
                Text("•Jugadores: ").bold() + Text("2 jugadores.")
              
                Text("•Objetivo: ").bold() + Text("Responder preguntas para subir el palo. Gana quien acierte primero el mayor número de preguntas de 5")
                
                (Text("•Cómo jugar: ").bold() +
                           Text("""
                               
                                    1. Presiona "Jugar".
                                    2. Aparecerá una pregunta sobre pueblos originarios de Chiapas.
                                    3. Toca la respuesta correcta antes que tu oponente.
                                    4. Acierto: Subes en el palo.
                                    5. Error: Te quedas en el mismo lugar.
                               """))
                           
                Text("•Fin del juego: ").bold() + Text("Quien acierte el mayor número de 5 preguntas, gana.")
                       }
                       .font(.system(size: 32))
                       .foregroundColor(.beige)
                       .multilineTextAlignment(.leading)
                       .fixedSize(horizontal: false, vertical: true)
                       .frame(width: 1000, height: 800)
                       .padding(.leading,100)
                       
        }
    }
}

#Preview {
    InstruccionesView(presentSideMenu: .constant(false))
}
