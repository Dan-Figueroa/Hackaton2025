//
//  Sala.swift
//  Raiva
//
//  Created by Dan Figueroa on 03/04/25.
//

import Foundation

struct sala: Hashable, Codable{
    var id: String
    var cantJugadores: Int
    var idJugadorUno: String
    var idJugadorDos: String
}
