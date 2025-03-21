//
//  InformateView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import SwiftUI

struct InformateView: View {
    @Binding var presentSideMenu: Bool
    @State private var selectedButton: String? = "tzoque"

    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            VStack {
                RaivaLogo(size: .large)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                ZStack {
                    MapComponent(mapaType: .noPointed, isFinding: true)
                        .frame(height: 400)
     
                    LocationComponent(state: selectedButton == "tzoque" ? .verde : .rojo, action: {
                        selectedButton = "tzoque"
                    })
                    .position(x: 538, y: 148)
                    
                    LocationComponent(state: selectedButton == "tzotsil" ? .verde : .rojo, action: {
                        selectedButton = "tzotsil"
                    })
                    .position(x: 572, y: 202)
                    
                    LocationComponent(state: selectedButton == "chol" ? .verde : .rojo, action: {
                        selectedButton = "chol"
                    })
                    .position(x: 688, y: 151)
                    
                    LocationComponent(state: selectedButton == "tojolabal" ? .verde : .rojo, action: {
                        selectedButton = "tojolabal"
                    })
                    .position(x: 679, y: 233)
                    
                    LocationComponent(state: selectedButton == "tzetal" ? .verde : .rojo, action: {
                        selectedButton = "tzetal"
                    })
                    .position(x: 745, y: 210)
                    
                    LocationComponent(state: selectedButton == "chuj" ? .verde : .rojo, action: {
                        selectedButton = "chuj"
                    })
                    .position(x: 746, y: 316)
                    
                    LocationComponent(state: selectedButton == "qanjobal1" ? .verde : .rojo, action: {
                        selectedButton = "qanjobal1"
                    })
                    .position(x: 832, y: 290)
                    
                    LocationComponent(state: selectedButton == "qanjobal2" ? .verde : .rojo, action: {
                        selectedButton = "qanjobal2"
                    })
                    .position(x: 654, y: 422)
                }
                
                Spacer()
            }
            .offset(x: -280, y: 70)

            HStack {
                Button {
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color.beige)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .offset(y: 32)

            VStack(spacing: 50) {
                Rectangle()
                    .overlay(
                        Text("text")
                            .font(.custom("Gagalin", size: 70))
                            .foregroundStyle(Color.beige)
                    )
                    .foregroundColor(Color.verdeBosque)
                    .frame(width: 400, height: 100)
                    .cornerRadius(30)
                    
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(1...4, id: \.self) { index in
                            Rectangle()
                                .foregroundColor(Color.verdeBosque)
                                .frame(width: 400, height: 400)
                                .cornerRadius(30)
                                .overlay(
                                    Text("Vista \(index)")
                                        .foregroundColor(.beige)
                                        .font(.custom("Gagalin", size: 70))
                                )
                                .padding(.horizontal, 10)
                        }
                    }
                }
                .frame(width: 450, height: 400)
                
                CustomButton(action: {}, fontColor: .beige, backgroundColor: .verdeBosque, buttonName: "Raiva")
                    .frame(width: 200)
            }
            .padding()
            .offset(x: 350, y: 100)
        }
    }
}

#Preview {
    InformateView(presentSideMenu: .constant(false))
        .environmentObject(AppData())
}
