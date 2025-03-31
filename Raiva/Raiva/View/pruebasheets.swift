//
//  pruebasheets.swift
//  Raiva
//
//  Created by Dan Figueroa on 30/03/25.
//
import SwiftUI

struct pruebasheets: View {
    @State private var showSheet1 = false
    @State private var showSheet2 = false
    @StateObject private var sheetViewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Mostrar Sheet 1") {
                showSheet1.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            
            Button("Mostrar Sheet 2") {
                showSheet2 = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Image(CurrentUser.shared.profilePicture)
        }
        .sheet(isPresented: $showSheet1) {
            LoginView()
                .environmentObject(AppData())
                .presentationBackground(.clear)
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $showSheet2) {
            RegisterView()
                .environmentObject(AppData())
                .presentationBackground(.clear)
                .interactiveDismissDisabled(true)

        }
    }
}
#Preview {
    pruebasheets()
}
