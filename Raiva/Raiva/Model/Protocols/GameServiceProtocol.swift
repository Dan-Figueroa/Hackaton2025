//
//  GameServiceProtocol.swift
//  Raiva
//
//  Created by Dan Figueroa on 03/04/25.
//

import Foundation
import FirebaseDatabase

protocol GameServiceProtocol {
    func crearSala() async throws -> Sala
    func unirseASala(salaId: String, jugadorId: String) async throws
    func observarSala(salaId: String, completion: @escaping (Sala?) -> Void) -> DatabaseHandle
    func removerObservador(salaId: String, handle: DatabaseHandle)
    func iniciarNuevaRonda(salaId: String, pregunta: String, respuestaCorrecta: String) async throws
    func finalizarJuego(salaId: String) async throws
    func abandonarSala(salaId: String, jugadorId: String) async throws
}
