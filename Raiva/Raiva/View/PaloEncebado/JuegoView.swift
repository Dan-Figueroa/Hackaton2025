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
    
    var body: some View {
        ZStack(alignment: .top) {
            Background(imageName: "fondoPE")
            MenuButton(presentSideMenu: $presentSideMenu)
            
            Spacer()
            
            CustomButton(action: {
                
            }, style: .image(imageName: "Sonido1"))
            .scaleEffect(0.8)
            .padding(.leading, 1100)
            
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
            }
           
            .fullScreenCover(isPresented: $mostrarInstrucciones) {
                InstruccionesView(presentSideMenu: .constant(false))
            }
        }
    }
}

#Preview {
    JuegoView(presentSideMenu: .constant(false))
        .environmentObject(AppData())
}
