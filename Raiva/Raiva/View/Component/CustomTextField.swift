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
    }
    
    let title: String
    let placeholder: String
    @Binding var text: String
    let type: FieldType
    var backgroundColor: Color
    var foregroundColor: Color
    var width: CGFloat
    var cornerRadius: CGFloat = 5
    var borderColor: Color
    var borderWidth: CGFloat = 3
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.leading, 5)
            
            Group {
                switch type {
                case .normal:
                    TextField(placeholder, text: $text)
                case .secure:
                    SecureField(placeholder, text: $text)
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
        }
    }
}
