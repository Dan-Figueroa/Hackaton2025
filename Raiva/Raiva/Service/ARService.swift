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
    
    func createARView() -> ARView {
        let arView = ARView(frame: .zero)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration)
        
        // Primer modelo (Mujer Chuj)
        if let model1 = loadCustomModel(
            baseName: genderEnum.woman.rawValue,
            clothingName: getModel(etnia: .chuj, gender: .woman),
            skinColor: .skin
        ) {
            model1.position = [-0.5, 0, -1] // Posición a la izquierda
            model1.orientation = simd_quatf(angle: .pi/2, axis: [0, 1, 0])
            
            let anchor1 = AnchorEntity(plane: .horizontal)
            anchor1.addChild(model1)
            arView.scene.anchors.append(anchor1)
        }
        
        // Segundo modelo (Hombre de otra etnia, por ejemplo Tzotzil)
        if let model2 = loadCustomModel(
            baseName: genderEnum.man.rawValue,
            clothingName: getModel(etnia: .chuj, gender: .man),
            skinColor: .skin
        ) {
            model2.position = [0.5, 0, -1] // Posición a la derecha
            model2.orientation = simd_quatf(angle: .pi/2, axis: [0, 1, 0])
            
            let anchor2 = AnchorEntity(plane: .horizontal)
            anchor2.addChild(model2)
            arView.scene.anchors.append(anchor2)
        }
        
        return arView
    }
    
    func loadCustomModel(baseName: String, clothingName: String, skinColor: UIColor) -> ModelEntity? {
        guard let baseEntity = try? ModelEntity.loadModel(named: baseName),
              let clothingEntity = try? ModelEntity.loadModel(named: clothingName) else {
            print("Error al cargar \(baseName) o \(clothingName)")
            return nil
        }
        
        clothingEntity.position = .zero
        baseEntity.addChild(clothingEntity)
        
        if let modelComponent = baseEntity.model {
            var newMaterials: [RealityKit.Material] = []
            for material in modelComponent.materials {
                if var physMaterial = material as? PhysicallyBasedMaterial {
                    physMaterial.baseColor.tint = skinColor
                    newMaterials.append(physMaterial)
                } else {
                    newMaterials.append(material)
                }
            }
            baseEntity.model?.materials = newMaterials
        }
        return baseEntity
    }
}

