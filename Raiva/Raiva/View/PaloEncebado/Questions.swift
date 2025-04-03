//
//  Questions.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//
import SwiftUI

struct Questions: View {
    @StateObject private var timerVM = TimerViewModel(tiempoTotal: 10)
    @StateObject private var questionVM = QuestionViewModel()
    
    var body: some View {
        ZStack(alignment: .center) {

            CardContainer(width: 700, height: 500, color: .arena)
            
            
            CardContainer(width: 660, height: 450, color: .beige, strokeColor: .brown) {
                VStack(spacing: 10) {
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 560, height: 30)
                            .foregroundColor(Color.gray.opacity(0.3))
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 560 * (timerVM.tiempoRestante / timerVM.tiempoTotal), height: 30)
                            .foregroundColor(tiempoColor)
                            .animation(.linear, value: timerVM.tiempoRestante)
                        
                        Text("\(Int(timerVM.tiempoRestante))s")
                            .frame(width: 560, alignment: .center)
                            .font(.custom("Gagalin", size: 20))
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 80)
                    .padding(.top, 10)
                 
                    
                    Text(questionVM.preguntaActual.texto)
                        .frame(width: 560)
                        .font(.custom("Gagalin", size: 25))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 60)
                    
                    
                    HStack(spacing: 20) {
                        ForEach(0..<questionVM.preguntaActual.opciones.count, id: \.self) { index in
                            CustomButton(
                                action: {
                                    questionVM.verificarRespuesta(opcionSeleccionada: index)
                                },
                                style: .standard(
                                    fontColor: .blanco,
                                    backgroundColor: colorParaOpcion(index: index),
                                    buttonName: questionVM.preguntaActual.opciones[index]
                                )
                            )
                            .frame(width: 180, height: 50)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            
           
            VStack {
                CardContainer(width: 400, height: 60, color: .arena)
                Spacer().frame(height: 95)
            }
            .offset(y: -190)
            
           
            CardContainer(width: 360, height: 40, color: .beige, strokeColor: .brown) {
                HStack(spacing: 80) {
                    GrayRectangle()
                    Text("Preguntas")
                        .font(.custom("Gagalin", size: 25))
                    GrayRectangle()
                }
            }
            .offset(y: -237)
        }
        .frame(height: 170)
        .onAppear {
            timerVM.iniciar()
        }
        .onDisappear {
            timerVM.detener()
        }
    }
    
    private func colorParaOpcion(index: Int) -> Color {
        guard questionVM.esCorrecto != nil else { return .yellow }
        
        if index == questionVM.preguntaActual.respuestaCorrecta {
            return .green
        } else if index == questionVM.respuestaSeleccionada {
            return .red
        }
        return .yellow
    }
    
    private var tiempoColor: Color {
        let porcentaje = timerVM.tiempoRestante / timerVM.tiempoTotal
        switch porcentaje {
        case 0..<0.3: return .red
        case 0.3..<0.6: return .orange
        default: return .green
        }
    }
    
    
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
