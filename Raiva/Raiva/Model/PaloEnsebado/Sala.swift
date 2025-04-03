//
//  Sala.swift
//  Raiva
//
//  Created by Dan Figueroa on 03/04/25.
//

import Foundation

struct Sala: Codable {
    let id: String
    var jugadores: [String]
    var estado: String
    var preguntaActual: String?
    var respuestaCorrecta: String?
    var rondaActual: Int = 1
    var maxRondas: Int = 5
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "jugadores": jugadores,
            "estado": estado,
            "preguntaActual": preguntaActual as Any,
            "respuestaCorrecta": respuestaCorrecta as Any,
            "rondaActual": rondaActual,
            "maxRondas": maxRondas
        ]
    }
    
    static func fromDictionary(_ dict: [String: Any]) -> Sala {
        return Sala(
            id: dict["id"] as? String ?? "",
            jugadores: dict["jugadores"] as? [String] ?? [],
            estado: dict["estado"] as? String ?? "esperando",
            preguntaActual: dict["preguntaActual"] as? String,
            respuestaCorrecta: dict["respuestaCorrecta"] as? String,
            rondaActual: dict["rondaActual"] as? Int ?? 1,
            maxRondas: dict["maxRondas"] as? Int ?? 5
        )
    }
}
