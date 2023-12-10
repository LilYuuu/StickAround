//
//  CanvasView.swift
//  Scribble
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @StateObject var viewModel: ViewModel
    
    var canvasView: PKCanvasView
    let toolPicker = PKToolPicker()

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.backgroundColor = .gray
        canvasView.drawingPolicy = .anyInput
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
    
    

}

//#Preview {
//    CanvasView()
//}
