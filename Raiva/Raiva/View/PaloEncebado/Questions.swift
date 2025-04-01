//
//  Questions.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//

import SwiftUI

struct Questions: View {
    @State private var tiempoRestante: CGFloat = 10
    @State private var tiempoTotal: CGFloat = 10
    @State private var timer: Timer?
    @State private var estaActivo = false
    
    var body: some View {
        ZStack(alignment: .center) {
            // Fondo principal
            CardContainer(width: 700, height: 500, color: .arena)
            
         
            CardContainer(width: 660, height: 450, color: .beige, strokeColor: .brown) {
                VStack(spacing: 10) {
                   
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 560, height: 20)
                            .foregroundColor(Color.gray.opacity(0.3))
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 560 * (tiempoRestante / tiempoTotal), height: 20)
                            .foregroundColor(tiempoColor)
                            .animation(.linear, value: tiempoRestante)
                    }
                    .padding(.top, 10)

                    Text("¡Pon a prueba tus conocimientos y sube hasta la cima del Palo Ensebado! 🌿")
                        .frame(width: 560)
                        .font(.custom("Gagalin", size: 25))
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Text("\(Int(tiempoRestante))s")
                            .font(.custom("Gagalin", size: 20))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            estaActivo.toggle()
                            estaActivo ? iniciarCronometro() : pausarCronometro()
                        }) {
                            Image(systemName: estaActivo ? "pause.fill" : "play.fill")
                                .font(.system(size: 20))
                        }
                    }
                    .frame(width: 560)
                    .padding(.bottom, 10)
                }
            }
        
            VStack {
                CardContainer(width: 400, height: 60, color: .arena)
                Spacer().frame(height: 95)
            }
            .offset(y: -190)
            
            CardContainer(width: 360, height: 40, color: .beige, strokeColor: .brown) {
                HStack(spacing: 80) {
                    GrayRectangle()
                    Text("Empecemos")
                        .font(.custom("Gagalin", size: 25))
                    GrayRectangle()
                }
            }
            .offset(y: -237)
        }
        .frame(height: 170)
        .onAppear {
            iniciarCronometro()
        }
        .onDisappear {
            detenerCronometro()
        }
    }
    
    private var tiempoColor: Color {
        let porcentaje = tiempoRestante / tiempoTotal
        switch porcentaje {
        case 0..<0.2: return .red
        case 0.2..<0.5: return .orange
        default: return .green
        }
    }

    private func iniciarCronometro() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if tiempoRestante > 0 {
                tiempoRestante -= 1
            } else {
                detenerCronometro()
            }
        }
    }
    
    private func pausarCronometro() { timer?.invalidate() }
    private func detenerCronometro() { timer?.invalidate(); estaActivo = false }
    private func reiniciarCronometro() { detenerCronometro(); tiempoRestante = tiempoTotal }
   
    private func CardContainer(
        width: CGFloat,
        height: CGFloat,
        color: Color,
        strokeColor: Color? = nil,
        @ViewBuilder content: () -> some View = { EmptyView() }
    ) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: width, height: height)
            .foregroundColor(color)
            .overlay(
                Group {
                    if let strokeColor = strokeColor {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(strokeColor, lineWidth: 2)
                    }
                }
            )
            .overlay(content())
    }
    
    private func GrayRectangle() -> some View {
        Rectangle()
            .frame(width: 20, height: 10)
            .foregroundColor(.gray)
            .cornerRadius(10)
    }
}

#Preview {
    Questions()
}
