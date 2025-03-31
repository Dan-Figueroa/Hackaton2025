//
//  ImagePickerComponent.swift
//  Raiva
//
//  Created by Dan Figueroa on 31/03/25.
//
import SwiftUI

struct ImagePickerComponent: View {
    @Binding var selectImage: String
    let availableImages: [String]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Selecciona una foto")
                .font(.custom("Gagalin", size: 28))
                .foregroundColor(.beige)
                .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(availableImages, id: \.self) { imageName in
                        Button(action: {
                            selectImage = imageName
                            dismiss()
                        }) {
                            roundedImageComponent(imageName: imageName)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .frame(minWidth: 600, minHeight: 500)
        .background(Color.verdeBosque)
    }
}


//LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) 3 columnas

#Preview {
    // Estado para simular el binding
    @Previewable @State var selectedImage = "foto1"
    
    // Lista de imágenes disponibles para el preview
    let sampleImages = ["foto1", "foto2", "foto3", "foto4", "foto5", "foto6"]
    
    return ImagePickerComponent(
        selectImage: $selectedImage,
        availableImages: sampleImages
    )
}
