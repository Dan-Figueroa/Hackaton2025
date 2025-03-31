//
//  SideMenuViewModel.swift
//  Raiva
//
//  Created by Jesus Ortega on 31/03/25.
//

import Foundation

class SideMenuViewModel: ObservableObject {
    @Published var imageName: String = CurrentUser.shared.profilePicture
    @Published var username: String = CurrentUser.shared.userName
    
}
