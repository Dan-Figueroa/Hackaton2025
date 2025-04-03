//
//  GameService.swift
//  Raiva
//
//  Created by Dan Figueroa on 03/04/25.
//

import Foundation
import Firebase

class GameService: GameServiceProtocol {
    private let connection: FirebaseConnectable
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
    }
    
    // MARK: - Gestión de Salas
    
    func crearSala() async throws -> Sala {
        let salasRef = connection.databaseReference.child("salas")
        let nuevaSalaRef = salasRef.childByAutoId()
        
        let sala = Sala(
            id: nuevaSalaRef.key ?? "unknown",
            jugadores: [],
            estado: "esperando",
            preguntaActual: nil,
            respuestaCorrecta: nil,
            rondaActual: 1,
            maxRondas: 5
        )
        
        try await nuevaSalaRef.setValue(sala.toDictionary())
        return sala
    }
    
    func unirseASala(salaId: String, jugadorId: String) async throws {
        let salaRef = connection.databaseReference.child("salas").child(salaId)
        
        try await salaRef.runTransactionBlock { currentData in
            guard var salaDict = currentData.value as? [String: Any] else {
                return TransactionResult.success(withValue: currentData)
            }
            
            var jugadores = salaDict["jugadores"] as? [String] ?? []
            
            // Verificaciones
            if jugadores.count >= 2 {
                currentData.value = salaDict
                return TransactionResult.success(withValue: currentData)
            }
            
            if jugadores.contains(jugadorId) {
                currentData.value = salaDict
                return TransactionResult.success(withValue: currentData)
            }
            
            // Actualización
            jugadores.append(jugadorId)
            salaDict["jugadores"] = jugadores
            
            if jugadores.count == 2 {
                salaDict["estado"] = "jugando"
            }
            
            currentData.value = salaDict
            return TransactionResult.success(withValue: currentData)
        }
    }
    
    func observarSala(salaId: String, completion: @escaping (Sala?) -> Void) -> DatabaseHandle {
        let salaRef = connection.databaseReference.child("salas").child(salaId)
        
        return salaRef.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            completion(Sala.fromDictionary(value))
        }
    }
    
    func removerObservador(salaId: String, handle: DatabaseHandle) {
        connection.databaseReference.child("salas").child(salaId).removeObserver(withHandle: handle)
    }
    
    // MARK: - Lógica del Juego
    
    func iniciarNuevaRonda(salaId: String, pregunta: String, respuestaCorrecta: String) async throws {
        let updates: [String: Any] = [
            "preguntaActual": pregunta,
            "respuestaCorrecta": respuestaCorrecta,
            "rondaActual": ServerValue.increment(1),
            "estado": "jugando"
        ]
        
        try await connection.databaseReference.child("salas").child(salaId).updateChildValues(updates)
    }
    
    func finalizarJuego(salaId: String) async throws {
        try await connection.databaseReference.child("salas").child(salaId)
            .updateChildValues(["estado": "finalizado"])
    }
    
    func abandonarSala(salaId: String, jugadorId: String) async throws {
        let salaRef = connection.databaseReference.child("salas").child(salaId)
        
        try await salaRef.runTransactionBlock { currentData in
            if var salaDict = currentData.value as? [String: Any] {
                var jugadores = salaDict["jugadores"] as? [String] ?? []
                jugadores.removeAll { $0 == jugadorId }
                salaDict["jugadores"] = jugadores
                
                if jugadores.isEmpty {
                    salaDict["estado"] = "finalizado"
                } else {
                    salaDict["estado"] = "esperando"
                }
                
                currentData.value = salaDict
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }
    }
}

enum GameError: Error {
    case salaLlena
    case jugadorYaEnSala
    case salaNoEncontrada
    case juegoYaTerminado
}
