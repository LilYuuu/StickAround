//
//  CanvasView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 12/5/23.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
//    @ObservedObject var viewModel: ViewModel
    
    var pkCanvas: PKCanvasView
    var toolPicker: PKToolPicker?

    func makeUIView(context: Context) -> PKCanvasView {
        
//        print("PKCanvasView initialized")
        
        pkCanvas.backgroundColor = .clear
        pkCanvas.drawingPolicy = .anyInput
        
//        pkCanvas.contentSize = CGSize(width: 100, height: 100)
        
        toolPicker?.setVisible(true, forFirstResponder: pkCanvas)
        toolPicker?.addObserver(pkCanvas)
        pkCanvas.becomeFirstResponder()
        
        // Add gesture handling to the PKCanvasView
//        pkCanvas.isUserInteractionEnabled = true
//        let gestureRecognizer = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleGesture(_:)))
//        pkCanvas.addGestureRecognizer(gestureRecognizer)
        
        
        return pkCanvas
    }
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: CanvasView
//        
//        init(parent: CanvasView) {
//            self.parent = parent
//        }
//        
//        @objc func handleGesture(_ gesture: UIPanGestureRecognizer) {
//            switch gesture.state {
//            case .changed:
//                // Handle drawing logic here
//                let location = gesture.location(in: parent.pkCanvas)
//                // Implement drawing logic based on the location
//                
//                // Disable list scrolling when drawing
//                parent.viewModel.listScrollingEnabled = false
//                print("Drawing - Disable scrolling")
//            case .ended:
//                // Enable list scrolling after drawing
//                parent.viewModel.listScrollingEnabled = true
//                print("Drawing - Enable scrolling")
//            default:
//                break
//            }
//        }
//    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}

#Preview {
    CanvasView(pkCanvas: PKCanvasView())
}
