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
        
        if let combinedModel = loadCustomModel(baseName: genderEnum.man.rawValue, clothingName: getModel(etnia: .chuj, gender: .man), skinColor: .arena) {
            combinedModel.position = [0, 0, -0.5]
            
            let anchor = AnchorEntity(plane: .horizontal)
            anchor.addChild(combinedModel)
            arView.scene.anchors.append(anchor)
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

