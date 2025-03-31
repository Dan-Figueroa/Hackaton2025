//
//  roundedImageComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 31/03/25.
//

import SwiftUI

struct roundedImageComponent: View {
    var imageName: String = ""
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke((imageName != "") ? Color.arena : Color.clear, lineWidth: 4)
            )
    }
}
#Preview {
    roundedImageComponent()
}
