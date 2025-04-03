//
//  Questions.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//
import SwiftUI

struct Questions: View {
    @EnvironmentObject private var juegoVM: JuegoPrincipalViewModel
    @StateObject private var timerVM = TimerViewModel(tiempoTotal: 10)
    @StateObject private var questionVM = QuestionViewModel()
    @Binding var mostrarPregunta: Bool
    
    @State private var mostrarAnimacionRespuesta = false
    @State private var mostrarMonedasGanadas = false
    private let recompensaMonedas = 100
    
    var body: some View {
        ZStack(alignment: .center) {
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 700, height: 500)
                .foregroundColor(.arena)
                .shadow(radius: 10)
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 660, height: 450)
                .foregroundColor(.beige)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.brown, lineWidth: 2)
                )
                .overlay(
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
                        
                        // Pregunta
                        Text(questionVM.preguntaActual.texto)
                            .frame(width: 560)
                            .font(.custom("Gagalin", size: 25))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 60)
                        
                        // Opciones de respuesta
                        HStack(spacing: 20) {
                            ForEach(0..<questionVM.preguntaActual.opciones.count, id: \.self) { index in
                                Button(action: {
                                    responderPregunta(index: index)
                                }) {
                                    Text(questionVM.preguntaActual.opciones[index])
                                        .font(.custom("Gagalin", size: 20))
                                        .foregroundColor(.white)
                                        .frame(width: 180, height: 50)
                                        .background(colorParaOpcion(index: index))
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.brown, lineWidth: 2)
                                        )
                                }
                                .disabled(questionVM.respuestaBloqueada)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                )
            
            // Encabezado
            VStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 400, height: 60)
                    .foregroundColor(.arena)
                Spacer().frame(height: 95)
            }
            .offset(y: -190)
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 360, height: 40)
                .foregroundColor(.beige)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.brown, lineWidth: 2)
                )
                .overlay(
                    HStack(spacing: 80) {
                        Capsule()
                            .frame(width: 20, height: 10)
                            .foregroundColor(.gray)
                        
                        Text("Preguntas")
                            .font(.custom("Gagalin", size: 25))
                        
                        Capsule()
                            .frame(width: 20, height: 10)
                            .foregroundColor(.gray)
                    }
                )
                .offset(y: -237)
            
            // Animación de respuesta y monedas
            if mostrarAnimacionRespuesta {
                VStack(spacing: 10) {
                    Text(questionVM.esCorrecto == true ? "¡Correcto!" : "Incorrecto")
                        .font(.custom("Gagalin", size: 40))
                        .foregroundColor(questionVM.esCorrecto == true ? .green : .red)
                    
                    if mostrarMonedasGanadas {
                        HStack(spacing: 10) {
                            Image("moneda")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text("+\(recompensaMonedas)")
                                .font(.custom("Gagalin", size: 30))
                                .foregroundColor(.arena)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .transition(.scale)
            }
        }
        .frame(height: 170)
        .onAppear {
            timerVM.iniciar()
            questionVM.prepararPreguntaAleatoria()
        }
        .onDisappear {
            timerVM.detener()
        }
        .onChange(of: timerVM.tiempoRestante) {_, tiempo in
            if tiempo <= 0 && !questionVM.respuestaBloqueada {
                manejarTiempoAgotado()
            }
        }
    }
    
    private func responderPregunta(index: Int) {
        questionVM.verificarRespuesta(opcionSeleccionada: index)
        
        withAnimation(.easeInOut(duration: 0.3)) {
            mostrarAnimacionRespuesta = true
        }
        
        // Asignar recompensa si es correcto
        if questionVM.esCorrecto == true {
            juegoVM.recompensarRespuestaCorrecta(jugadorIzquierdo: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    mostrarMonedasGanadas = true
                }
            }
        }
        
        timerVM.detener()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                mostrarPregunta = false
                
                if questionVM.esCorrecto == true {
                    juegoVM.subirIzquierdo()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                resetearParaSiguientePregunta()
            }
        }
    }
    
    private func manejarTiempoAgotado() {
        withAnimation {
            mostrarAnimacionRespuesta = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                mostrarPregunta = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                resetearParaSiguientePregunta()
            }
        }
    }
    
    private func resetearParaSiguientePregunta() {
        questionVM.prepararPreguntaAleatoria()
        mostrarAnimacionRespuesta = false
        mostrarMonedasGanadas = false
    }
    
    private func colorParaOpcion(index: Int) -> Color {
        if questionVM.respuestaBloqueada {
            if index == questionVM.preguntaActual.respuestaCorrecta {
                return .green
            } else if index == questionVM.respuestaSeleccionada {
                return .red
            }
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
}
