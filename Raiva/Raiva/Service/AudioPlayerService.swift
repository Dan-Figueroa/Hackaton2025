//
//  AudioPlayerService.swift
//  Raiva
//
//  Created by Jesus Ortega on 26/03/25.
//

import Foundation
import AVFAudio
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(named soundName: String, loop: Bool = true) {
        stopSound() // Detener cualquier reproducción previa
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Error: No se encontró el archivo de audio '\(soundName).mp3'")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.numberOfLoops = loop ? -1 : 0 // -1 para loop infinito
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error al reproducir el sonido: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    deinit {
        stopSound()
        try? AVAudioSession.sharedInstance().setActive(false)
    }
}
