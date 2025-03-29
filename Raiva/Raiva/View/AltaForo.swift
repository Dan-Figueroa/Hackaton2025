//
//  AltaForo.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//
import SwiftUI

struct AltaForo: View {
    @StateObject private var foroData = AltaForoViewModel()
    @State private var wordCount: Int = 0
    
    var body: some View {
        Rectangle()
            .frame(width: 800, height: 600)
            .foregroundColor(Color.verdeBosque)
            .opacity(0.9)
            .overlay(
                VStack(spacing: 10) {
                    HStack {
                        CustomButton(action: {}, style: .image(imageName: "x"))
                            .scaleEffect(0.5)
                            
                        Spacer()
                        
                        Picker("Selecciona una comunidad", selection: $foroData.selectedEthnicity) {
                            ForEach(EtniasEnum.allCases, id: \.self) { ethnicity in
                                Text(ethnicity.rawValue).tag(ethnicity)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .frame(width: 250)
                        .background(Color.verdeBosque)
                        .cornerRadius(8)
                        .foregroundColor(.arena)
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                    HStack {
                        UserViewType(imageName: "perfilInvitado", name: "Meliza Gonzales", style: .horizontal)
                            .scaleEffect(1.4)
                            .padding(.leading,160)
                        
                        Spacer()
                    }

                    
                    VStack(spacing: 30) {
                        ZStack(alignment: .trailing) {
                            TextField("Título del post", text: $foroData.postTitle)
                                .textFieldStyle(.plain)
                                .padding()
                                .frame(width: 720)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.beige, lineWidth: 1)
                                )
                                .foregroundColor(.white)
                                .font(.headline)
                                .onChange(of: foroData.postTitle) {
                                    wordCount = foroData.postTitle.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.count
                                }
                            
                            Text("\(wordCount)/30")
                                .foregroundColor(wordCount > 30 ? .red : .beige)
                                .padding(.trailing, 10)
                        }
                        .padding(.top, 5)
                        
                        TextEditor(text: $foroData.postContent)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .frame(width: 720, height: 200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.beige, lineWidth: 1)
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    HStack {
                        Spacer()
                        CustomButton(action: {
                            print("Publicando: \(foroData.postTitle)")
                        }, style: .standard(fontColor: .beige, backgroundColor: .verdeBosque, buttonName: "Publicar"))
                            .frame(width: 150)
                            .padding(.top, 20)
                            .padding(.trailing, 20)
                    }
                    .padding(.bottom, 20)
                }
            )
    }
}

#Preview {
    AltaForo()
}
