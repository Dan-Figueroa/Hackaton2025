//
//  ARViewModel.swift
//  Raiva
//
//  Created by Jesus Ortega on 17/03/25.
//

import SwiftUI
import ARKit
import RealityKit

class ARViewModel: ObservableObject {
    private let arService = ARService()
    
    func getARView() -> ARView {
        return arService.createARView()
    }
}
