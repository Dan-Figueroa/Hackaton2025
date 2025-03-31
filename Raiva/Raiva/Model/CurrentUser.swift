//
//  CurrentUser.swift
//  Raiva
//
//  Created by Jesus Ortega on 28/03/25.
//

import Foundation

final class CurrentUser{
    
    static let shared = CurrentUser()
    private var _user: User? // Contenedor del usario actual
    
    var id: String { _user?.id ?? "" }
    var userName: String { _user?.userName ?? "perfilInvitado" }
    
    var profilePicture: String { _user?.profilePicture ?? "profileInvitado" }
    
    var etnia: EtniasEnum.RawValue? { _user?.etnia }
    
    var isLogged: Bool {_user != nil}
    
    func updateUser(user: User){
        _user = user
        print("UsuaioActualizado")
        print(_user?.id ?? "")
    }
    
    func logout(){
        _user = nil
    }
    
    func getActualUser() -> User?{
        return _user
    }
    
}

