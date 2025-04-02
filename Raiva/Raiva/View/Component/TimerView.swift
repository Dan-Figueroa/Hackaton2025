//
//  TimerView.swift
//  Raiva
//
//  Created by Dan Figueroa on 02/04/25.
//

import SwiftUI

struct TimerView: View {
    @Binding var tiempoRestante: CGFloat
    @Binding var tiempoTotal: CGFloat
    @Binding var estaActivo: Bool
    
    var tiempoColor: Color {
        let porcentaje = tiempoRestante / tiempoTotal
        switch porcentaje {
        case 0..<0.3: return .red
        case 0.3..<0.6: return .orange
        default: return .green
        }
    }
    
    var body: some View {
        VStack(spacing: 5) {
            // Barra de progreso
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 560, height: 20)
                    .foregroundColor(Color.gray.opacity(0.3))
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 560 * (tiempoRestante / tiempoTotal), height: 20)
                    .foregroundColor(tiempoColor)
                    .animation(.linear, value: tiempoRestante)
            }
            
            // Controles del timer
            HStack {
                Text("\(Int(tiempoRestante))s")
                    .font(.custom("Gagalin", size: 20))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    estaActivo.toggle()
                }) {
                    Image(systemName: estaActivo ? "pause.fill" : "play.fill")
                        .font(.system(size: 20))
                }
            }
            .frame(width: 560)
        }
    }
}

