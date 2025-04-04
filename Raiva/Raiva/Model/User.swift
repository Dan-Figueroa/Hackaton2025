//
//  User.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import Foundation

struct User: Codable, Hashable, Identifiable{
    var id: String = ""
    var userName: String = "perfilInvitado"
    var profilePicture: String = "profileInvitado"
    var etnia: EtniasEnum.RawValue?
}
