//
//  ViewModel.swift
//  Scribble
//
//  Created by Lily Yu on 11/30/23.
//

import Foundation
import PencilKit
import RealityKit
import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var savedDrawing = UIImage()
    
    func clearDrawing() {
        savedDrawing = UIImage()
    }
    
    func saveDrawing() {
//        let image = saved.image(from: drawing.bounds, scale: UIScreen.main.scale)
        let data = savedDrawing.pngData()
        
        // TODO: turn into texture for AR
//        guard let textureResource = try? TextureResource.generate(from: data as! CGImage, options: .init(semantic: .color))
//        else {
//            return
//        }
//        savedDrawing = UIImage(ciImage: .red)
        print("drawing saved")
    }
    
}
