//
//  CustomCheckbox.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//

import SwiftUI

struct CustomCheckbox: View {
    let label: String
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isChecked ? .verdeBosque : .secondary)
            
            Text(label)
                .foregroundColor(.verdeBosque)
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}
