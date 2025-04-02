//
//  ComunidadesView.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//

import SwiftUI

struct ComunidadesView: View {
    @Binding var showCreateComunity: Bool
    var body: some View {
        VStack {
            HeadComponent(
                filterAction: {
                    print("Filtrar presionado")
                },
                createAction: {
                    showCreateComunity = true
                }
            )
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            Rectangle()}
        .frame(width: 1000, height: 700)
        .foregroundColor(.verdeBosque.opacity(0.6))
        .cornerRadius(20)
    }
}


#Preview {
    ComunidadesView(showCreateComunity: .constant(false))
        .environmentObject(AppData())
}
