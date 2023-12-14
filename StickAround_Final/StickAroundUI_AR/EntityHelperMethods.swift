//
//  EntityHelperMethods.swift
//  StickAroundUI_AR
//
//  Created by Lily Yu on 12/7/23.
//

import Foundation
import SwiftUI
import ARKit
import RealityKit

// Custom message plane entity
class MessagePlaneEntity: Entity {
    var messageEntity: MessageEntity
    
    var modelEntity: ModelEntity
    
    var planeMesh: MeshResource
        
    init(message: Message, planeAnchor: ARPlaneAnchor) {
        self.messageEntity = MessageEntity(message: message)

        self.planeMesh = .generatePlane(width: planeAnchor.planeExtent.width, depth: planeAnchor.planeExtent.height)
        
        var transparentMaterial = SimpleMaterial(color: UIColor(.gray).withAlphaComponent(0.5), isMetallic: false)
        transparentMaterial.tintColor = .white.withAlphaComponent(0.999)
        //        transparentMaterial.color = Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        self.modelEntity = ModelEntity(mesh: self.planeMesh, materials: [transparentMaterial])
        // for debug
//        self.modelEntity = ModelEntity(mesh: self.planeMesh, materials: [UnlitMaterial(color: .red)])
        
        // generate collision shapes for tapping detection
        self.modelEntity.generateCollisionShapes(recursive: true)
        
        super.init()
        
        self.addChild(self.messageEntity)
        self.addChild(self.modelEntity)
        self.messageEntity.position.y += 0.001
        
        // Enable tapping detection on the entity
        
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}

// Custom message entity
class MessageEntity: Entity {
    var modelEntity: ModelEntity
    
    init(message: Message) {
        let planeMesh = MeshResource.generatePlane(width: 0.5, depth: 0.5, cornerRadius: 0.05)
        self.modelEntity = ModelEntity(mesh: planeMesh)
        
        super.init()
        
        self.updateMessageTexture(message: message)
        
        self.addChild(modelEntity)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func updateMessageTexture(message: Message) {
//        print("UPDATE MESSAGE TEXTURE", message)
        guard let textureResource = self.makeTexture(message: message) else {
            print("Error making texture from message", message)
            return
        }
        
        let texture = MaterialParameters.Texture(textureResource)
        
        var material = PhysicallyBasedMaterial()
        material.baseColor = .init(tint: .white.withAlphaComponent(0.999), texture: texture)
//        material.blending = .transparent(opacity: 0.999)
        material.textureCoordinateTransform.scale = SIMD2<Float>(x: 1, y: 1)
            

        
        self.modelEntity.model?.materials = [material]
    }
    
    private func makeTexture(message: Message) -> TextureResource? {
        let renderer = ImageRenderer(content: MessageView(message: .constant(message)))
        
        // Get this back to viewModel
        let uiImage = UIImage(cgImage:  renderer.cgImage!)
        
        
        return renderer.cgImage.flatMap { cgImage in
            return try? TextureResource.generate(from: cgImage, options: .init(semantic: .color))
        }
    }
}
