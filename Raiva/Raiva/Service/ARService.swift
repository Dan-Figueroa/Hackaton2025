//
//  ARService.swift
//  Raiva
//
//  Created by Jesus Ortega on 17/03/25.
//

import ARKit
import RealityKit
import SwiftUI

class ARService {
    func createDualCultureView(etnia: EtniasEnum) -> ARView {
        let arView = ARView(frame: .zero)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration)
        
        // Modelo Mujer
        if let womanModel = loadCustomModel(
            baseName: genderEnum.woman.rawValue,
            clothingName: getModel(etnia: etnia, gender: .woman),
            skinColor: .skin
        ) {
            womanModel.position = [-0.5, 0, -1] // Izquierda
            womanModel.orientation = simd_quatf(angle: .pi/2, axis: [0, 1, 0])
            
            let womanAnchor = AnchorEntity(plane: .horizontal)
            womanAnchor.addChild(womanModel)
            arView.scene.anchors.append(womanAnchor)
        }
        
        // Modelo Hombre
        if let manModel = loadCustomModel(
            baseName: genderEnum.man.rawValue,
            clothingName: getModel(etnia: etnia, gender: .man),
            skinColor: .skin
        ) {
            manModel.position = [0.5, 0, -1] // Derecha
            manModel.orientation = simd_quatf(angle: .pi/2, axis: [0, 1, 0])
            
            let manAnchor = AnchorEntity(plane: .horizontal)
            manAnchor.addChild(manModel)
            arView.scene.anchors.append(manAnchor)
        }
        
        return arView
    }
    
    private func loadCustomModel(baseName: String, clothingName: String, skinColor: UIColor) -> ModelEntity? {
        guard let baseEntity = try? ModelEntity.loadModel(named: baseName),
              let clothingEntity = try? ModelEntity.loadModel(named: clothingName) else {
            print("Error al cargar: Base=\(baseName) o Ropa=\(clothingName)")
            return nil
        }
        
        clothingEntity.position = .zero
        baseEntity.addChild(clothingEntity)
        
        // Aplicar color de piel
        if let modelComponent = baseEntity.model {
            var materials = modelComponent.materials
            for i in 0..<materials.count {
                if var material = materials[i] as? PhysicallyBasedMaterial {
                    material.baseColor.tint = skinColor
                    materials[i] = material
                }
            }
            baseEntity.model?.materials = materials
        }
        
        return baseEntity
    }
}
