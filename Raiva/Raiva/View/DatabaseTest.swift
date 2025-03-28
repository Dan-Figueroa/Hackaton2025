//
//  DatabaseTest.swift
//  Raiva
//
//  Created by Jesus Ortega on 28/03/25.
//

import SwiftUI
import Combine

struct DatabaseTest: View {
    @ObservedObject var viewModel = ForumViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Button("Agregar Usuario") {
                    viewModel.agregarUsuario(user: userData)
                }
                .padding()
                
                ForEach(viewModel.users, id: \.self) { usuario in
                    UserRowView(user: usuario)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .refreshable {
            viewModel.cargarUsuariosUnaVez()
        }
    }
}

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack {
            Text(user.userName)
            Spacer()
            Text(user.etnia ?? "Sin etnia")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    DatabaseTest()
}
