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
                    viewModel.crearForo(userID: "OMVx_zLKidSzuepp_pr", foro: forumData)
                }
                .padding()
                
                ForEach(viewModel.users, id: \.self) { usuario in
                    ForumComponent(communityData: communityData, userData: userData, forumData: forumData)
                }.padding()
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
