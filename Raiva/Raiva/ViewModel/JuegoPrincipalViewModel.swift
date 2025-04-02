//
//  JuegoPrincipalViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 01/04/25.
//

import Foundation

class JuegoPrincipalViewModel: ObservableObject {
    @Published var user: User?
    @Published var coins: Int = 0
    @Published var leftScore: Int = 0
    @Published var rightScore: Int = 0
    @Published var leftMoveY: Int = 170
    @Published var rightMoveY: Int = 170
    
    private let minY: Int = -50
    private let maxY: Int = 170
  
    func subirIzquierdo(cantidad: Int = 90) {
        guard leftMoveY > minY else { return }
        leftMoveY -= cantidad
        leftScore += 1  
        darMonedaIzquierda()
    }

    func subirDerecho(cantidad: Int = 90) {
        guard rightMoveY > minY else { return }
        rightMoveY -= cantidad
        rightScore += 1
        darMonedaDerecha()
    }
    
    private func darMonedaDerecha() {
        coins += 100
    }
    
    private func darMonedaIzquierda() {
        coins += 100
    }
    
    func reiniciarPosiciones() {
        leftMoveY = maxY
        rightMoveY = maxY
    }
  
    func reiniciarScores() {
        leftScore = 0
        rightScore = 0
    }
}
