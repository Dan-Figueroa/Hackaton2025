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
    var person: Int = 1
    @StateObject private var audioPlayer = AudioPlayer()
    var body: some View {
        ZStack {
            // Vista principal del juego
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
                        //coinsRightCard
                    }
                    .padding(.bottom, 100)
                    
                    HStack(spacing: 400) {
                        Image("paloEncebado")
                            .scaleEffect(1.5)
                        
                        Image("paloEncebado")
                            .scaleEffect(1.5)
                    }
                    
                    Spacer()
                    
                    buttons
                }
                personLeftCard
                personRightCard
            }
            .disabled(mostrarEmpecemos || mostrarBusqueda)
        
            if mostrarEmpecemos {
                Empecemos()
                    .transition(.opacity)
                    .onAppear {
                        audioPlayer.playSound(named: "músicaFondo", loop: true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                mostrarEmpecemos = false
                                mostrarBusqueda = true
                                
                                // Simulación de encontrar oponente después de 7 segundos
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    encontradoOponente = true
                                }
                            }
                        }
                    }
                    .zIndex(1)
            }
            
            // Vista de búsqueda
            if mostrarBusqueda {
                BusquedaView(shouldDismiss: $encontradoOponente)
                    .transition(.opacity)
                    .onChange(of: encontradoOponente) { _, newValue in
                        if newValue {
                            withAnimation {
                                mostrarBusqueda = false
                            }
                        }
                    }
                    .zIndex(1)
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
                    if (person != 0){
                        Text("\(juegoVM.leftCoins)")
                            .font(.custom("Gagalin", size: 40))
                            .foregroundColor(.arena)
                        
                    }else{
                        Text("\(juegoVM.rightCoins)")
                            .font(.custom("Gagalin", size: 40))
                            .foregroundColor(.arena)
                    }
                }
            )
    }
    
    private var coinsRightCard: some View {
        Rectangle()
            .frame(width: 220, height: 70)
            .foregroundColor(.black.opacity(0.3))
            .cornerRadius(30)
            .overlay(
                HStack(spacing: 20) {
                    Image("moneda")
                    Text("\(juegoVM.rightCoins)")
                        .font(.custom("Gagalin", size: 40))
                        .foregroundColor(.arena)
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
                
        }.animation(.easeOut(duration: 0.8), value: juegoVM.leftMoveY)

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
                juegoVM.subirIzquierdo()
            }, style: .image(imageName: "music"))
            
            CustomButton(action: {
                juegoVM.subirDerecho()
                //juegoVM.reiniciarPosiciones()
                //juegoVM.reiniciarScores()
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
