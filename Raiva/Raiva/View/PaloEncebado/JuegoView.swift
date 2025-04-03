//
//  JuegoView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//
import SwiftUI

struct JuegoView: View {
    @Binding var presentSideMenu: Bool
    @State private var mostrarJuegoPrincipal = false
    @State private var mostrarInstrucciones = false
    @StateObject private var audioPlayer = AudioPlayer()
    @State private var isSoundOn = true
    
    var body: some View {
        ZStack(alignment: .top) {
            Background(imageName: "fondoPE")
            MenuButton(presentSideMenu: $presentSideMenu)
            
            Spacer()
         
            CustomButton(action: {
                isSoundOn.toggle()
                if isSoundOn {
                    audioPlayer.playSound(named: "musicaFondo", loop: true)
                } else {
                    audioPlayer.stopSound()
                }
            }, style: .image(imageName: isSoundOn ? "music" : "nomusic"))
            .scaleEffect(1)
            .padding(.top,20)
            
            .padding(.leading, 1000)
            
            VStack {
                Image("logoPE").resizable()
                    .frame(width: 700, height: 300)
                
                VStack(spacing: 60) {
                    ZStack {
                        CustomButton(action: {
                            mostrarInstrucciones = true
                        }, style: .image(imageName: "instrucciones"))
                        .scaleEffect(6)
                        .offset(y: 100)
                        
                        CustomButton(action: {
                            mostrarJuegoPrincipal = true
                        }, style: .image(imageName: "jugar"))
                        .scaleEffect(2.5)
                    }
                }
            }
            .padding(.trailing, -300)
            .padding(.top, 110)
        
            .fullScreenCover(isPresented: $mostrarJuegoPrincipal) {
                JuegoPrincipal()
                    .onDisappear {
                        if isSoundOn {
                            audioPlayer.playSound(named: "musicaFondo", loop: true)
                        }
                    }
            }
           
            .fullScreenCover(isPresented: $mostrarInstrucciones) {
                InstruccionesView(presentSideMenu: .constant(false))
            }
        }
        .onAppear {
            if isSoundOn {
                audioPlayer.playSound(named: "musicaFondo", loop: true)
            }
        }
        .onDisappear {
            audioPlayer.stopSound()
        }
    }
}
#Preview {
    JuegoView(presentSideMenu: .constant(false))
        .environmentObject(AppData())
}
