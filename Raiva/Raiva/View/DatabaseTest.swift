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
                    print("hoal")
                }
                .padding()
                
                ForEach(viewModel.communities, id: \.self) { usuario in
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
            viewModel.cargarForosEnTiempoReal()
        }
    }
}

struct UserRowView: View {
    let user: Community
    
    var body: some View {
        HStack {
            Text(user.communityName)
            Spacer()
            Text(user.communityOwner)
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
