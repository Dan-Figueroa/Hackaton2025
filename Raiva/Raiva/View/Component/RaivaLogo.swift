//
//  RaivaLogo.swift
//  Raiva
//
//  Created by Jesus Ortega on 13/03/25.
//

import SwiftUI

struct RaivaLogo: View {
    @EnvironmentObject var appData: AppData
    let size: raivaLogoSize
    var body: some View {
        
        HStack(spacing: 15){
            Group{
                size.logoSize(appData: appData)
                size.textSize(appData: appData)
            }
        }.frame(maxWidth: .infinity)
    }
    
    enum raivaLogoSize{
        case small
        case medium
        case large
        
        func logoSize(appData: AppData) -> some View {
            var size: CGFloat
                switch self {
                case .small:
                    size = appData.UISW * 0.03
                case .medium:
                    size = appData.UISW * 0.06
                case .large:
                    size = appData.UISW * 0.1
                }
            return Image("logo")
                .resizable()
                .frame(maxWidth: size, maxHeight: size)
        }
        
        func textSize(appData: AppData) -> some View{
            var size: CGFloat
                switch self{
                case .small:
                    size = appData.UISW * 0.02
                case .medium:
                    size = appData.UISW * 0.05
                case .large:
                    size = appData.UISW * 0.1
                }
            return Text("Raiva")
                .font(.custom("Gagalin", size: size))
                .foregroundStyle(Color.beige)
        }
    }
}


#Preview {
    RaivaLogo(size: .large)
        .environmentObject(AppData())
}

// MARK: - Ejemplo de cómo utilizar esta view

/*
 
 struc ejemplo: View{
    var body: some view{
        RaivaLogo(size: .small)
            .environmentObject(AppData())
    }
 }
 
 */
