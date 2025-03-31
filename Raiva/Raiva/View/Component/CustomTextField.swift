//
//  CustomTextField.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//

import SwiftUI

struct CustomTextField: View {
    enum FieldType {
        case normal
        case secure
        case textEditor
    }
    
    let title: String
    let placeholder: String
    @Binding var text: String
    let type: FieldType
    var backgroundColor: Color
    var foregroundColor: Color
    var tittleColor: Color
    var width: CGFloat
    var cornerRadius: CGFloat = 5
    var borderColor: Color
    var borderWidth: CGFloat = 3
    var height: CGFloat = 70 // Solo usado para textEditor
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.leading, 5)
                .foregroundStyle(tittleColor)
            
            Group {
                switch type {
                case .normal:
                    TextField(placeholder, text: $text)
                case .secure:
                    SecureField(placeholder, text: $text)
                case .textEditor:
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $text)
                            .focused($isFocused)
                            .scrollContentBackground(.hidden)
                            .frame(height: height)
                        
                        if text.isEmpty && !isFocused {
                            Text(placeholder)
                                .foregroundColor(foregroundColor.opacity(0.5))
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                    }
                }
            }
            .textFieldStyle(.plain)
            .padding()
            .frame(width: width)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius + 3)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .font(.headline)
            .foregroundColor(foregroundColor)
            .onAppear {
                // Configuración para TextEditor
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}
