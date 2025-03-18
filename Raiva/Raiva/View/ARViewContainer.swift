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
    @ObservedObject var viewModel: ARViewModel

    func makeUIView(context: Context) -> ARView {
        return viewModel.getARView()
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

#Preview {
    ARViewContainer(viewModel: ARViewModel())
}

