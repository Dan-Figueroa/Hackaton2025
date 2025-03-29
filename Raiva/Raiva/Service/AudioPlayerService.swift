//
//  AudioPlayerService.swift
//  Raiva
//
//  Created by Jesus Ortega on 26/03/25.
//

import Foundation
import AVFAudio
import AVFoundation

class AudioPlayer: NSObject, ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(named soundName: String) {
        audioPlayer?.stop()
   
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Error: No se encontró el archivo de audio '\(soundName).mp3'")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error al reproducir el sonido: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
    
    func toggleSound(named soundName: String) {
        if audioPlayer?.isPlaying == true {
            stopSound()
        } else {
            playSound(named: soundName)
        }
    }
}
