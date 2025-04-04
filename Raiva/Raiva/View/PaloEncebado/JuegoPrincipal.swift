//
//  JuegoPrincipal.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//
import SwiftUI

struct JuegoPrincipal: View {
    @StateObject private var juegoVM = JuegoPrincipalViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var mostrarEmpecemos = true
    @State private var mostrarBusqueda = false
    @State private var encontradoOponente = false
    @State private var mostrarPregunta = false
    @State private var juegoTerminado = false
    var personD: Int = 1
    var personI: Int = 0

    var body: some View {
        ZStack {
            ZStack(alignment: .center) {
                Background(imageName: "fondoPES")
                
                VStack {
                    HStack(spacing: 40) {
                        Image("logoPE")
                            .resizable()
                            .frame(width: 250, height: 100)
                            .padding(.leading, -120)
                    
                        playerCard
                        coinsLeftCard
                        scoreCard
                    }
                    .padding(.bottom, 100)
                    
                    HStack(spacing: 400) {
                        Image("paloEncebado")
                            .scaleEffect(1.5)
                        
                        Image("paloEncebado")
                            .scaleEffect(1.5)
                    }
                    
                    Spacer()
                }
                personLeftCard
                personRightCard
            }
            .disabled(mostrarEmpecemos || mostrarBusqueda || mostrarPregunta || juegoTerminado)
        
            if mostrarEmpecemos {
                Empecemos()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                mostrarEmpecemos = false
                                mostrarBusqueda = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    encontradoOponente = true
                                }
                            }
                        }
                    }
                    .zIndex(1)
            }
            
            if mostrarBusqueda {
                BusquedaView(shouldDismiss: $encontradoOponente)
                    .transition(.opacity)
                    .onChange(of: encontradoOponente) { _, newValue in
                        if newValue {
                            withAnimation {
                                mostrarBusqueda = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    mostrarPregunta = true
                                }
                            }
                        }
                    }
                    .zIndex(1)
            }
            
            if mostrarPregunta {
                Questions(mostrarPregunta: $mostrarPregunta)
                    .transition(.opacity)
                    .environmentObject(juegoVM)
                    .onAppear {
                        juegoVM.jugadorActual = .izquierdo
                        juegoVM.esTurnoDelBot = false
                    }
                    .onDisappear {
                        if juegoVM.leftScore >= 3 || juegoVM.rightScore >= 3 {
                            juegoTerminado = true
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                mostrarPregunta = true
                            }
                        }
                    }
                    .zIndex(2)
            }
            
            if juegoTerminado {
                GanadorView(ganador: juegoVM.leftScore >= 3 ? "Jugador Izquierdo" : "Jugador Derecho", action: {
                    juegoVM.reiniciarJuego()
                    juegoTerminado = false
                    mostrarPregunta = false
                    encontradoOponente = false
                    mostrarBusqueda = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        encontradoOponente = true
                    }
                }, action2: {})
                .transition(.opacity)
                .zIndex(3)
            }
        }
    }
    
    
    private var playerCard: some View {
        ZStack {
            Rectangle()
                .frame(width: 220, height: 70)
                .foregroundColor(.black.opacity(0.3))
                .cornerRadius(30)
            
            UserViewType(imageName: "perfilInvitado", name: "Jesus", style: .horizontal)
                .frame(width: 200, height: 130)
        }
    }
    
    private var coinsLeftCard: some View {
        Rectangle()
            .frame(width: 220, height: 70)
            .foregroundColor(.black.opacity(0.3))
            .cornerRadius(30)
            .overlay(
                HStack(spacing: 20) {
                    Image("moneda")
                    if (personD == 1){
                        Text("\(juegoVM.leftCoins)")
                            .font(.custom("Gagalin", size: 40))
                            .foregroundColor(.arena)
                    } else {
                        Text("\(juegoVM.rightCoins)")
                            .font(.custom("Gagalin", size: 40))
                            .foregroundColor(.arena)
                    }
                }
            )
    }
    
    private var scoreCard: some View {
        Rectangle()
            .frame(width: 220, height: 70)
            .foregroundColor(.black.opacity(0.3))
            .cornerRadius(30)
            .overlay(
                HStack(spacing: 20) {
                    Text("\(juegoVM.leftScore)")
                        .font(.custom("Gagalin", size: 40))
                        .foregroundColor(.blue)
                    Text("-")
                        .font(.custom("Gagalin", size: 40))
                        .foregroundColor(.arena)
                    Text("\(juegoVM.rightScore)")
                        .font(.custom("Gagalin", size: 40))
                        .foregroundColor(.red)
                }
            )
    }
    
    private var personLeftCard: some View {
        VStack {
            Text("Jesus")
                .font(.custom("Gagalin", size: 20))
                .offset(x: -305, y: CGFloat(juegoVM.leftMoveY))
            Image(systemName: "arrowshape.down.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .offset(x: -305, y: CGFloat(juegoVM.leftMoveY))
            
             Image("personajeIzquierdo")
                .scaleEffect(1.2)
                .offset(x: -275, y: CGFloat(juegoVM.leftMoveY))
        }
        .animation(.easeOut(duration: 0.8), value: juegoVM.leftMoveY)
    }
    
    private var personRightCard: some View {
        VStack {
            Text("Dan")
                .font(.custom("Gagalin", size: 20))
                .offset(x: 290, y: CGFloat(juegoVM.rightMoveY))
            Image(systemName: "arrowshape.down.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .offset(x: 290, y: CGFloat(juegoVM.rightMoveY))
            
            Image("personajeDerecho")
                .scaleEffect(1.2)
                .offset(x: 260, y: CGFloat(juegoVM.rightMoveY))
        }
        .animation(.easeOut(duration: 0.8), value: juegoVM.rightMoveY)
    }
    
    private var buttons: some View {
        HStack(spacing: 40) {
            CustomButton(action: {
               
            }, style: .image(imageName: "back"))
            
            CustomButton(action: {
                dismiss()
            }, style: .image(imageName: "exit"))
        }
        .padding(.leading, -20)
    }
}

#Preview {
    JuegoPrincipal()
}
