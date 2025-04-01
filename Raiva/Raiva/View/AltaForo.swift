//
//  AltaForo.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//
import SwiftUI

struct AltaForo: View {
    @StateObject private var foroDataViewModel = AltaForoViewModel()
    @State private var wordCount: Int = 0
    
    var body: some View {
        Rectangle()
            .frame(width: 900, height: 700)
            .foregroundColor(Color.verdeBosque)
            .opacity(0.9)
            .cornerRadius(30)
            .overlay(
                VStack(spacing: 10) {
                    HStack {
                        CustomButton(action: {}, style: .image(imageName: "x"))
                            .scaleEffect(0.5)
                        
                        Spacer()
                        
                        CommunityPickerView(selectedEthnicity: $foroDataViewModel.selectedEthnicity)
                        

                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    HStack {
                        UserViewType(imageName: CurrentUser.shared.profilePicture, name: CurrentUser.shared.userName, style: .horizontal)
                            .scaleEffect(1.2)
                            .padding(.leading,150)
                        
                        //tSpacer()
                    }
                    
                    
                    VStack(spacing: 30) {
                        ZStack(alignment: .trailing) {
                            TextField("Título del post", text: $foroDataViewModel.postTitle)
                                .textFieldStyle(.plain)
                                .padding()
                                .frame(width: 720)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.beige, lineWidth: 1)
                                )
                                .foregroundColor(.white)
                                .font(.headline)
                                .onChange(of: foroDataViewModel.postTitle) {
                                    wordCount = foroDataViewModel.postTitle.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.count
                                }
                            
                            Text("\(wordCount)/30")
                                .foregroundColor(wordCount > 30 ? .red : .beige)
                                .padding(.trailing, 10)
                        }
                        .padding(.top, 5)
                        
                        TextEditor(text: $foroDataViewModel.postContent)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .frame(width: 720, height: 250)
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
                            print("Publicando: \(foroDataViewModel.postTitle)")
                            
                            foroDataViewModel.publicar()
                            
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

struct CommunityPickerView: View {
    @Binding var selectedEthnicity: EtniasEnum
    @State private var showPicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Botón que muestra la selección actual
            HStack {
                Image(selectedEthnicity.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(selectedEthnicity.rawValue)
                    .foregroundColor(.arena)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(showPicker ? 180 : 0))
                    .foregroundColor(.arena)
            }
            .padding()
            .frame(width: 250)
            .background(Color.verdeBosque.opacity(0.4))
            .cornerRadius(8)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showPicker.toggle()
                }
            }
            
            // Opciones del picker con ScrollView
            if showPicker {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(EtniasEnum.allCases, id: \.self) { ethnicity in
                            HStack {
                                Image(ethnicity.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                
                                Text(ethnicity.rawValue)
                                    .foregroundColor(.arena)
                                
                                Spacer()
                                
                                if selectedEthnicity == ethnicity {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.arena)
                                }
                            }
                            .padding()
                            .frame(width: 250, height: 40)
                            .background(Color.verdeBosque.opacity(0.3))
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation {
                                    selectedEthnicity = ethnicity
                                    showPicker = false
                                }
                            }
                        }
                    }
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.verdeBosque.opacity(0.5), lineWidth: 1)
                    )
                }
                .frame(height: min(CGFloat(EtniasEnum.allCases.count) * 50, 200)) // Altura máxima de 200
                .transition(.opacity.combined(with: .move(edge: .top)))
                .zIndex(1)
            }
        }
    }
}

#Preview {
    AltaForo()
    //CommunityPickerView(selectedEthnicity: .constant(EtniasEnum.chol))
}
