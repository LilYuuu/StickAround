//
//  ARView.swift
//  CustomizableMessagePlane
//
//  Created by Lily Yu on 11/9/23.
//

// Code example for delegation functions: https://github.com/augmentedhacking/ar-plane-classification

import Foundation
import SwiftUI
import ARKit
import RealityKit
import Combine

struct ARViewContainer: UIViewRepresentable {
    let viewModel: ViewModel
    
    func makeUIView(context: Context) -> ARView {
        let arView = SimpleARView(frame: .zero, viewModel: viewModel)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

class SimpleARView: ARView {
    let viewModel: ViewModel
    private var subscriptions = Set<AnyCancellable>()
    
//    var planeAnchor: AnchorEntity?
    var messagePlaneEntity: MessagePlaneEntity?
    
    // Dictionary for storing ARPlaneAnchor(s) with AnchorEntity(s)
    var anchorEntityMap: [ARPlaneAnchor: AnchorEntity] = [:]
    
    init(frame: CGRect, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        self.setupARSession()
//        self.setupScene()
        self.setupSubscriptions()
    }
    
    private func setupARSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical, .horizontal]
        
        let options: ARSession.RunOptions = [.removeExistingAnchors]
        
        self.session.delegate = self
        
        session.run(configuration, options: options)
    }
    
    private func setupScene() {
//        let planeAnchor = AnchorEntity(plane: .vertical)
//        scene.addAnchor(planeAnchor)
        
//        let messagePlaneEntity = MessagePlaneEntity(message: viewModel.message, planeAnchor: <#ARPlaneAnchor#>)
//        planeAnchor.addChild(messagePlaneEntity)
//        self.messagePlaneEntity = messagePlaneEntity
        
    }
    
    private func resetScene() {
//        messagePlaneEntity?.removeFromParent()
//        messagePlaneEntity = nil
        
//        planeAnchor?.removeFromParent()
//        planeAnchor = nil
        
        // TODO: clear the anchor entity array
        
        for (_, anchorEntity) in anchorEntityMap {
            // Remove all child entities of the anchor entity
            anchorEntity.children.removeAll()

            // Remove the anchor entity itself from the scene
            anchorEntity.removeFromParent()

            // Remove the ARPlaneAnchor
            if let planeAnchor = anchorEntity.anchor as? ARPlaneAnchor {
                // Remove the anchor from the session
                self.session.remove(anchor: planeAnchor)
            }
        }
        
        // Clear the anchorEntityMap
        anchorEntityMap.removeAll()
        
        setupARSession()
        
//        setupScene()
    }
    
    private func setupSubscriptions() {
        // Subscribe to message changes and regenerate texture
        // Drop first message so this doesn't run when app first loads
        self.viewModel.$message.dropFirst().sink { message in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.anchorEntityMap.values.forEach { anchorEntity in
                    // let messageEntity = anchorEntity.findEntity(named: "message-plane") as? MessagePlaneEntity
                    let messageEntities: [MessagePlaneEntity] = anchorEntity.children.compactMap { entity in
                        return entity as? MessagePlaneEntity
                    }
                    
                    messageEntities.forEach { entity in
                        entity.messageEntity.updateMessageTexture(message: message)
                    }
                }
                
                
                // This only updates the last reference
                // self.messagePlaneEntity?.messageEntity.updateMessageTexture(message: message)
            }
        }.store(in: &subscriptions)
        
        
        // Subscribe to reset signal
        self.viewModel.resetSignal.sink { [weak self] in
            guard let self = self else { return }
            self.resetScene()
        }.store(in: &subscriptions)
    }
}

// MARK: - Implement ARSessionDelegate protocol
extension SimpleARView: ARSessionDelegate {
    // Tells the delegate that one or more anchors have been added to the session.
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // Filter added anchors for plane anchors
        let planeAnchors = anchors.compactMap { $0 as? ARPlaneAnchor }
        
        planeAnchors.forEach {
            // Create a RealityKit anchor at plane anchor's position
            let anchorEntity = AnchorEntity()
            
            /* --------- Plane Visualization Stuff --------- */
            
            // Estimated size of detected plane
//            let extent = $0.planeExtent
            
            // Generate a rough plane mesh based on anchor extent
            // Later we will update this plane based on more detailed geometry as ARKit learns more about our environment
//            let planeMesh: MeshResource = .generatePlane(width: extent.width,
//                                                         depth: extent.height)
            
            // Set color based on plane classification using our extension defined at bottom of this file
            let planeClassification = $0.classification
            
//            let modelEntity = ModelEntity(mesh: planeMesh,
//                                          materials: [planeClassification.debugMaterial])
            
            // Add plane model entity to anchor entity
//            anchorEntity.addChild(modelEntity)
            
            /* -------------------------------------------- */
            
            // Create a message plane entity based on the plane anchor
            self.messagePlaneEntity =
            MessagePlaneEntity(message: viewModel.message, planeAnchor: $0)
            
            // Add message plane entity to anchor entity
            anchorEntity.addChild(self.messagePlaneEntity!)
            
            // Assign AR plane anchor's transform to our anchor Entity
            anchorEntity.transform.matrix = $0.transform
            
            // Add anchor entity to our scene
            self.scene.addAnchor(anchorEntity)
            
            // Store ARKit's ARPlaneAnchor along with our associated RealityKit Anchor Entity
            self.anchorEntityMap[$0] = anchorEntity
        }
    }
    
    //Tells the delegate that the session has adjusted the properties of one or more anchors.
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // Filter updated anchors for plane anchors
        let planeAnchors = anchors.compactMap { $0 as? ARPlaneAnchor }
        
        planeAnchors.forEach { planeAnchor in
            // Look for an associated AnchorEntity in our dictionary, otherwise do nothing
            guard let anchorEntity = self.anchorEntityMap[planeAnchor] else {
                return
            }
            
            
            /* --------- Plane Visualization Stuff --------- */
            
            // Look for AnchorEntity's first child that is a model entity
            // A better way to do this would use a custom entity, but this works for the tutorial
            guard let messagePlaneEntity = (anchorEntity
                .children
                .compactMap { $0 as? MessagePlaneEntity }
                .first) else {
                    return
                }
            
            // Get detailed plane geometry
            var meshDescriptor = MeshDescriptor(name: "plane")
            meshDescriptor.positions = MeshBuffers.Positions(planeAnchor.geometry.vertices)
            meshDescriptor.primitives = .triangles(planeAnchor.geometry.triangleIndices.map { UInt32($0)})
            
            DispatchQueue.main.async {
                // Try creating mesh from detailed ARPlaneGeometry
                if let mesh = try? MeshResource.generate(from: [meshDescriptor]) {
                    messagePlaneEntity.modelEntity.model?.mesh = mesh
                }
                
                
                let bounds = messagePlaneEntity.modelEntity.visualBounds(relativeTo: messagePlaneEntity.modelEntity)
                
                let center = bounds.center
                messagePlaneEntity.messageEntity.position = bounds.center
                messagePlaneEntity.messageEntity.position.y = center.y + 0.001
            }
//
            // Get detailed plane geometry
//            var meshDescriptor = MeshDescriptor(name: "plane")
//            meshDescriptor.positions = MeshBuffers.Positions(planeAnchor.geometry.vertices)
//            meshDescriptor.primitives = .triangles(planeAnchor.geometry.triangleIndices.map { UInt32($0)})
//
//            DispatchQueue.main.async {
                // Try creating mesh from detailed ARPlaneGeometry
//                if let mesh = try? MeshResource.generate(from: [meshDescriptor]) {
//                    modelEntity?.model?.mesh = mesh
//                }
//
//                let planeClassification = planeAnchor.classification
//                modelEntity?.model?.materials = [planeClassification.debugMaterial]
//            }
            
            /* -------------------------------------------- */
            
            
            // Update message plane entity's transform
//            messagePlaneEntity?.transform = Transform(matrix: planeAnchor.transform)
            
//            print(messagePlaneEntity)
                        
            
        }
    }
    
    // Tells the delegate that one or more anchors have been removed from the session.
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        // Filter removed anchors for plane anchors
        let planeAnchors = anchors.compactMap { $0 as? ARPlaneAnchor }
        
        planeAnchors.forEach {
            // Look for an associated AnchorEntity in our dictionary, otherwise do nothing
            guard let anchorEntity = self.anchorEntityMap[$0] else {
                return
            }
            
            // Remove anchor entity from scene and dictionary
            anchorEntity.removeFromParent()
            self.anchorEntityMap.removeValue(forKey: $0)
        }
    }
}

// Extension for coloring planes by classification
extension ARPlaneAnchor.Classification {
    var debugMaterial: SimpleMaterial {
        return SimpleMaterial(color: self.debugColor.withAlphaComponent(0.9),
                              isMetallic: false)
    }
    
    var debugColor: UIColor {
        switch self {
        case .ceiling:
            return .blue
        case .door:
            return .magenta
        case .floor:
            return .red
        case .seat:
            return .green
        case .table:
            return .yellow
        case .wall:
            return .cyan
        case .window:
            return .white
        default:
            return .gray
        }
    }
}
