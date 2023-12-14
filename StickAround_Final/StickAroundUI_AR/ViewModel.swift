//
//  ViewModel.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import Foundation
import Combine
import SwiftUI
import RealityKit
import PencilKit

class ViewModel: ObservableObject {

//    @Published var message: Message = Message(sender: "El", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sodales posuere augue mollis posuere. Curabitur lectus massa, suscipit vitae malesuada in, ultrices quis nulla.", location: "Wall", time: "2023-10-25 15:22:42",  backgroundColor: .yellow, fontColor: .white, fontSize: 200)
    @Published var message: Message = Message(sender: "", text: "", room: "Bedroom", location: "Wall", time: "", backgroundColor: .yellow, fontColor: .white, fontSize: 200)
    
    @Published var messages: [Message] = []
    
    @Published var useGridView: Bool = false
    
    
    // Single pass through subject ("signal") for resetting the view.
    @Published var resetSignal: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    /* ----- scribble ----- */
    @Published var savedDrawing = UIImage()
//    @Published var listScrollingEnabled = true
    
    func clearDrawing() {
        savedDrawing = UIImage()
    }
    
    func saveDrawing() {
//        let image = drawing.image(from: drawing.bounds, scale: UIScreen.main.scale)
        let data = savedDrawing.pngData()
        // TODO: turn into texture for AR
//        guard let textureResource = try? TextureResource.generate(from: data as! CGImage, options: .init(semantic: .color))
//        else {
//            return
//        }
//        savedDrawing = UIImage(ciImage: .red)
        print("drawing saved")
    }
    /* ---------------- */
}



