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

    @Published var message: Message = Message(sender: "", text: "", location: "Wall", time: "2023-10-25 15:22:42",  backgroundColor: .yellow, fontColor: .white, fontSize: 200)
    
    /* ----- scribble ----- */
    @Published var savedDrawing = UIImage()
    
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


struct Message {
    var sender: String
    var text: String  // TODO: test with longer text
    var location: String
    var time: String
    var backgroundColor: Color
    var fontColor: Color
    var fontSize: CGFloat
}
