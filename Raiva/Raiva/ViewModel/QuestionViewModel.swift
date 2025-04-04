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
            respuestaCorrecta: 2
        ),
        Question(
            texto: "El shote es el platillo tipico de los:",
            opciones: ["Zoques", "Mames", "Choles"],
            respuestaCorrecta: 2
        ),
        Question(
            texto: "¿Cuál es la festividad más común entre la comunidad Tojolabal?",
            opciones: ["La Candelaria", "La Fiesta Santa Cruz", "Navidad"],
            respuestaCorrecta: 1
        ),
        Question(
            texto: "El caldo de res con hierbas es el platillo local de los:",
            opciones: ["Tojolabales", "Mames", "Mixtecos"],
            respuestaCorrecta: 0
        ),
        Question(
            texto: "Corresponde a la festividad del pueblo Tzeltal:",
            opciones: ["Carnaval San Agustín", "Carnaval Coteico", "Carnaval Tenejapa"],
            respuestaCorrecta: 2
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
        ),
        Question(
            texto: "¿Pueblo originario que su platillo típico no es el tamal?",
            opciones: ["Mam", "Q'anjobal", "Zoque"],
            respuestaCorrecta: 0
        ),
        Question(
            texto: "El platillo típico del pueblo Q'anjob'al es:",
            opciones: ["Tamal de masa", "Maíz", "Frijoles"],
            respuestaCorrecta: 0
        ),
        Question(
            texto: "¿Cuál es la bebida tradicional del pueblo Q'anjob'al asociada al trabajo en el campo?",
            opciones: ["Atole", "Pozol", "Tepache"],
            respuestaCorrecta: 1
        ),
        Question(
            texto: "Festividad común entre la comunidad Chol:",
            opciones: ["Día de muertos", "Santa cruz", "Fiesta de San Pedro y San Pablo"],
            respuestaCorrecta: 2
        ),
        Question(
            texto: "La cantidad 9625 corresponde a la población:",
            opciones: ["Mam", "Q'anjob'al", "Tzeltal"],
            respuestaCorrecta: 1
        ),
        Question(
            texto: "¿Qué comunidad tiene una población de aproximadamente 13,031 personas?",
            opciones: ["Mam","Tzotzil","Chol"],
            respuestaCorrecta: 0
        ),
        Question(
            texto: "¿Qué alimento está muy marcado en la gastronomía de los Tzotsiles?",
            opciones: ["Trigo","Abas","Maíz"],
            respuestaCorrecta: 2
        )
        
    ]
    
    @Published var preguntaActual: Question
        @Published var puntuacion = 0
        @Published var mostrarResultado = false
        @Published var esCorrecto: Bool?
        @Published var respuestaSeleccionada: Int?
        @Published var respuestaBloqueada = false
        
        private var preguntasMostradas: [UUID] = []
        
        init() {
            self.preguntaActual = preguntas.randomElement()!
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
            preguntasMostradas.append(preguntaActual.id)
            
            let preguntasDisponibles = preguntas.filter { !preguntasMostradas.contains($0.id) }
            
            if !preguntasDisponibles.isEmpty {
                preguntaActual = preguntasDisponibles.randomElement()!
            } else {
                reiniciarCuestionario()
                return
            }
            
            mostrarResultado = false
            esCorrecto = nil
            respuestaSeleccionada = nil
            respuestaBloqueada = false
        }
            
        func prepararPreguntaAleatoria() {
            mostrarResultado = false
            esCorrecto = nil
            respuestaSeleccionada = nil
            respuestaBloqueada = false
            
            var preguntasDisponibles = preguntas
            preguntasDisponibles.removeAll { $0.id == preguntaActual.id }
            
            if let nuevaPregunta = preguntasDisponibles.randomElement() {
                preguntaActual = nuevaPregunta
            } else {
                preguntaActual = preguntas.randomElement()!
            }
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
