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
                        coinsCard
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
                    
                    buttons
                }
                personLeftCard
                personRightCard
            }
            .disabled(mostrarEmpecemos)
            if mostrarEmpecemos {
                Empecemos()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                mostrarEmpecemos = false
                            }
                        }
                    }
                    .zIndex(1)
            }
        }
    }
            /*HStack {
               
                Button(action: {
                    juegoVM.subirIzquierdo()
                }) {
                    ControlButton(systemName: "arrow.up.circle.fill", color: .blue)
                }
                
                Spacer()
                Button(action: {
                    juegoVM.subirDerecho()
                }) {
                    ControlButton(systemName: "arrow.up.circle.fill", color: .red)
                }
            }
            .padding(.horizontal, 40)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 50)*/
    

    struct ControlButton: View {
        let systemName: String
        let color: Color
        
        var body: some View {
            Image(systemName: systemName)
                .font(.system(size: 60))
                .foregroundColor(.white)
                .background(Circle().fill(color).shadow(radius: 5))
                .padding()
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
    
    private var coinsCard: some View {
        Rectangle()
            .frame(width: 220, height: 70)
            .foregroundColor(.black.opacity(0.3))
            .cornerRadius(30)
            .overlay(
                HStack(spacing: 20) {
                    Image("moneda")
                    Text("\(juegoVM.coins)")
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
        Image("personajeIzquierdo")
            .scaleEffect(1.2)
            .offset(x: -275, y: CGFloat(juegoVM.leftMoveY))
            .animation(.easeOut(duration: 0.8), value: juegoVM.leftMoveY)
    }
    
    private var personRightCard: some View {
        Image("personajeDerecho")
            .scaleEffect(1.2)
            .offset(x: 260, y: CGFloat(juegoVM.rightMoveY))
            .animation(.easeOut(duration: 0.8), value: juegoVM.rightMoveY)
    }
    
    private var buttons: some View{
        HStack (spacing: 40){
            CustomButton(action: {
                
            }, style: .image(imageName: "music"))
            
            CustomButton(action: {
                juegoVM.reiniciarPosiciones()
                juegoVM.reiniciarScores()
            }, style: .image(imageName: "back"))
            
            CustomButton(action: {
                dismiss()
            }, style: .image(imageName: "exit"))
        }.padding(.leading,-20)
    }
}

#Preview {
    JuegoPrincipal()
}
