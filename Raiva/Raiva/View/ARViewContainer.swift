//
//  ARViewContainer.swift
//  Raiva
//
//  Created by Jesus Ortega on 17/03/25.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        return ARService().createARView()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}


