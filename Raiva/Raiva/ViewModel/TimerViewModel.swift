//
//  TimerViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 02/04/25.
//

import Foundation
class TimerViewModel: ObservableObject {
    @Published var tiempoRestante: CGFloat
    @Published var tiempoTotal: CGFloat
    @Published var estaActivo = false
    
    private var timer: Timer?
    
    init(tiempoTotal: CGFloat) {
        self.tiempoTotal = tiempoTotal
        self.tiempoRestante = tiempoTotal
    }
    
    func iniciar() {
        detener()
        estaActivo = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.tiempoRestante > 0 {
                self.tiempoRestante -= 1
            } else {
                self.detener()
            }
        }
    }
    
    func pausar() {
        timer?.invalidate()
        estaActivo = false
    }
    
    func detener() {
        timer?.invalidate()
        estaActivo = false
    }
    
    func reiniciar() {
        detener()
        tiempoRestante = tiempoTotal
    }
    
    deinit {
        detener()
    }
}
