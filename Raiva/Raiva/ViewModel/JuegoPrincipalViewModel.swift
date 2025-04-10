//
//  JuegoPrincipalViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//

import Foundation

class JuegoPrincipalViewModel: ObservableObject {
    @Published var leftCoins: Int = 0
    @Published var rightCoins: Int = 0
    @Published var leftScore: Int = 0
    @Published var rightScore: Int = 0
    @Published var leftMoveY: Int = 130
    @Published var rightMoveY: Int = 130
    @Published var esTurnoDelBot = false
    @Published var jugadorActual: Jugador = .izquierdo
    @Published var juegoTerminado = false
    @Published var ganador: String = ""
    
    enum Jugador {
        case izquierdo
        case derecho
    }
    
    private let minY: Int = -80
    private let maxY: Int = 130
    
    func subirIzquierdo(cantidad: Int = 90) {
        guard leftMoveY > minY else { return }
        leftMoveY -= cantidad
        leftScore += 1
        darMonedaIzquierda()
        verificarGanador()
    }
        
    func subirDerecho(cantidad: Int = 90) {
        guard rightMoveY > minY else { return }
        rightMoveY -= cantidad
        rightScore += 1
        darMonedaDerecha()
        verificarGanador()
    }
        
    func darMonedaDerecha(cantidad: Int = 100) {
        rightCoins += cantidad
    }
           
    func darMonedaIzquierda(cantidad: Int = 100) {
        leftCoins += cantidad
    }
    
    func recompensarRespuestaCorrecta(jugadorIzquierdo: Bool) {
        let cantidad = 100
        if jugadorIzquierdo {
            darMonedaIzquierda(cantidad: cantidad)
        } else {
            darMonedaDerecha(cantidad: cantidad)
        }
    }
    
    func manejarRespuestaCorrecta(para jugador: Jugador) {
        switch jugador {
        case .izquierdo:
            subirIzquierdo()
            recompensarRespuestaCorrecta(jugadorIzquierdo: true)
        case .derecho:
            subirDerecho()
            recompensarRespuestaCorrecta(jugadorIzquierdo: false)
        }
    }
    
    func alternarTurno() {
        guard !juegoTerminado else { return }
        esTurnoDelBot.toggle()
        jugadorActual = (jugadorActual == .izquierdo) ? .derecho : .izquierdo
    }
    
    func verificarGanador() {
        if leftScore >= 3 {
            ganador = "Jugador Izquierdo"
            juegoTerminado = true
        } else if rightScore >= 3 {
            ganador = "Jugador Derecho"
            juegoTerminado = true
        }
    }
        
    func reiniciarPosiciones() {
        leftMoveY = maxY
        rightMoveY = maxY
    }
      
    func reiniciarScores() {
        leftScore = 0
        rightScore = 0
    }
        
    func reiniciarMonedas() {
        leftCoins = 0
        rightCoins = 0
    }
    
    func reiniciarJuego() {
        reiniciarPosiciones()
        reiniciarScores()
        reiniciarMonedas()
        jugadorActual = .izquierdo
        esTurnoDelBot = false
        juegoTerminado = false
        ganador = ""
    }
}
