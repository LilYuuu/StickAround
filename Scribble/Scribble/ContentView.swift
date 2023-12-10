//
//  ContentView.swift
//  Scribble
//
//  Created by Lily Yu on 11/30/23.
//
// Tutorial for PencilKit: https://www.youtube.com/watch?v=PkJ9dB-Ou_w

import SwiftUI
import PencilKit

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    @State var canvasView = PKCanvasView()
    
    var body: some View {
        VStack {
            
            HStack {
                Button("Clear") {
                    viewModel.clearDrawing()
//                    viewModel.drawing = 
                    canvasView.drawing = PKDrawing()
                    print("Drawing cleared")
                }
                Spacer()
                Text("Scribbling!")
                    .bold()
                Spacer()
                Button("Save") {
                    viewModel.saveDrawing()
                    
                    let drawing = canvasView.drawing
                    let image = drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
                    
                    // let data = image.pngData()
                    
                    print(">>>> 1", drawing.bounds, canvasView.bounds)
                    guard let data = image.pngData() else { return }
                    
                    print(">>>> 2")
                    
                    guard let pngImage = UIImage(data: data) else { return }
                    
                    print(">>>> 3")
                    viewModel.savedDrawing = image
                    
                    print(viewModel.savedDrawing)
                }
            }
            CanvasView(viewModel: viewModel, canvasView: canvasView)
                .frame(width: 240, height: 240)
                .padding()

            
            ZStack {
                Image(uiImage: viewModel.savedDrawing).scaledToFit()
                    .border(.blue)
            }
            .frame(width: 240, height: 240)
            .onReceive(viewModel.$savedDrawing, perform: { _ in
                print("Drawing updated")
            })
            
////            Spacer()
//            Image(uiImage: viewModel.savedDrawing)
//                .frame(width: 300, height: 300)
            Text("Scribble saved")
//                .
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    ContentView()
}
