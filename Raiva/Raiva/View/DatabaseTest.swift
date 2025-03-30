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
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        ScrollView {
            VStack {
                Button("Agregar Usuario") {
                    viewModel.getUsuarioPorUserName(userName: "Jesus Ortega A.")
                }
                .padding()
                
                ForEach(viewModel.users, id: \.self) { usuario in
                    //                    ForumComponent(communityData: communityData, userData: userData, forumData: forumData)
                    UserRowView(user: usuario)
                }.padding()
                
                if let user = viewModel.user {
                    Text("Nombre de usuario: \(user.userName)")
                    Text("Etina: \(user.etnia ?? "Sin etnia")")
                    Text("ProfilePic: \(user.profilePicture)")
                } else {
                    Text("Cargando usuario...")
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
        .environmentObject(AppData())
}
