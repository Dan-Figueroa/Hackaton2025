//
//  QuestionViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 02/04/25.
//

import Foundation

class QuestionViewModel: ObservableObject {
    struct Question: Identifiable {
        let id = UUID()
        let texto: String
        let opciones: [String]
        let respuestaCorrecta: Int
    }
    
    private let preguntas: [Question] = [
        Question(
            texto: "¿Qué pueblo originario celebra el carnaval coteico?",
            opciones: ["Tzotzil", "Zoque", "Tzeltal"],
            respuestaCorrecta: 1
        ),
        Question(
            texto: "La fiesta de San Sebastián Martir la celebran los:",
            opciones: ["Choles", "Tzeltales", "Tzotziles"],
            respuestaCorrecta: 1
        ),
        Question(
            texto: "Platillo típico del pueblo originario Chol",
            opciones: ["Tamal de chipilín", "Frijoles", "Shote"],
            respuestaCorrecta: 2
        ),
        Question(
            texto: "¿Cuál es la festividad más común entre la comunidad Tojolabal?",
            opciones: ["La Candelaria", "La Fiesta Santa Cruz", "Navidad"],
            respuestaCorrecta: 1
        ),
        Question(
            texto: "El caldo de res con hierbas es local de los:",
            opciones: ["Tojolabales", "Mames", "Mixtecos"],
            respuestaCorrecta: 0
        ),
        Question(
            texto: "Corresponde a la festividad del pueblo Tzeltal:",
            opciones: ["Carnaval San Agustín", "Carnaval Coteico", "Carnaval Tenejapa"],
            respuestaCorrecta: 1
        ),
        Question(
            texto: "Cantidad de población Chuj en Chiapas:",
            opciones: ["219", "229", "2190"],
            respuestaCorrecta: 0
        ),
        Question(
            texto: "La cantidad 49,729 es el número de habitantes de la comunidad:",
            opciones: ["Chol", "Zoque", "Mam"],
            respuestaCorrecta: 1
        )
    ]
    
    @Published var preguntaActual: Question
    @Published var puntuacion = 0
    @Published var mostrarResultado = false
    @Published var esCorrecto: Bool?
    @Published var respuestaSeleccionada: Int?
    @Published var respuestaBloqueada = false // Nueva propiedad para controlar selección única
    
    init() {
        self.preguntaActual = preguntas[0]
    }
    
    func verificarRespuesta(opcionSeleccionada: Int) {
        
        guard !respuestaBloqueada else { return }
        
        respuestaSeleccionada = opcionSeleccionada
        respuestaBloqueada = true
        
        if opcionSeleccionada == preguntaActual.respuestaCorrecta {
            puntuacion += 10
            esCorrecto = true
        } else {
            esCorrecto = false
        }
        mostrarResultado = true
    }
    
    func siguientePregunta() {
        if let indiceActual = preguntas.firstIndex(where: { $0.id == preguntaActual.id }) {
            let siguienteIndice = (indiceActual + 1) % preguntas.count
            preguntaActual = preguntas[siguienteIndice]
        }
        mostrarResultado = false
        esCorrecto = nil
        respuestaSeleccionada = nil
        respuestaBloqueada = false
    }
    
   
    func reiniciarCuestionario() {
        preguntaActual = preguntas[0]
        puntuacion = 0
        mostrarResultado = false
        esCorrecto = nil
        respuestaSeleccionada = nil
        respuestaBloqueada = false
    }
}
