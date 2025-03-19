//
//  ForumComponent.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import SwiftUI

struct ForumComponent: View {
    @EnvironmentObject var appDaata: AppData
    var body: some View {
        ZStack{
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundStyle(Color.verdeBosque.opacity(0.75))
                .frame(width: .infinity, height: .infinity)
            
            HStack{
                
            }
            
        }.frame(width: .infinity, height: .infinity)
    }
}

//struct



#Preview {
    ForumComponent()
        .frame(width: 600, height: 400)
}
