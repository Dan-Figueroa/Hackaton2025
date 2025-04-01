//
//  InstruccionesView.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//

import SwiftUI

struct InstruccionesView: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            Background(imageName: "fondoPE")

            Rectangle()
                .frame(width: 1100, height: 750)
                .cornerRadius(40)
                .opacity(0.3)
            
            HStack {
                CustomButton(action: {
                    presentSideMenu.toggle()
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
                Text("•Jugadores: ").bold() + Text("2-4 jugadores")
              
                Text("•Objetivo: ").bold() + Text("Responder preguntas para subir el palo. Gana quien acierte primero el mayor número de preguntas de 5.")
                
                (Text("•Como jugar: ").bold() +
                           Text("""
                               
                                    1. Presiona jugar.
                                    2. Aparecerá una pregunta sobre pueblos originarios de Chiapas.
                                    3. Toca la respuesta correcta antes que tu oponente.
                                    4. Acierto: Subes en el palo.
                                    5. Error: Te quedas en el mismo lugar.
                               """))
                           
                Text("•Fin de Juego: ").bold() + Text("Quien acierte el mayor número de 5 preguntas, gana.")
                       }
                       .font(.system(size: 32))
                       .foregroundColor(.beige)
                       .multilineTextAlignment(.leading)
                       .fixedSize(horizontal: false, vertical: true)
                       .frame(maxWidth: 700, alignment: .leading)
                       .padding(.leading, 350)
                       .padding(.trailing, 40)
                       .padding(.top, 50)
        }
    }
}

#Preview {
    InstruccionesView(presentSideMenu: .constant(false))
}
