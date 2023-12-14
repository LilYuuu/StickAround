//
//  ScribbleView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI
import PencilKit

struct ScribbleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel = ViewModel()
    
    @State var canvasView = PKCanvasView()
    @State var toolPicker: PKToolPicker? = PKToolPicker()
    
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // bg
                    Color("lightYellow")
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        // header
                        HStack {
                            Button(action: { self.presentationMode.wrappedValue.dismiss()
                                self.canvasView.resignFirstResponder()
                                self.toolPicker?.setVisible(false, forFirstResponder: self.canvasView)
//                                self.toolPicker = nil
                            }) {
                                Text("Back")
                                    .foregroundStyle(Color.black)
                            }
                            Spacer()
                            Text("Scribbling!")
                                .bold()
                                .font(.title3)
                            Spacer()
                            Button("Clear") {
                                viewModel.clearDrawing()
                                canvasView.drawing = PKDrawing()
                                print("Drawing cleared")
                            }.foregroundStyle(Color.black)
                        }
                        .padding()
                        .background(Color.white.opacity(0.75).ignoresSafeArea())
                        
//                        ZStack {
//                            MessageView(message: $viewModel.message)
//                                .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
//                                .scaleEffect(geometry.size.width / 2048 / 1.5) // TODO: magic number?
//                            VStack {
//                                CanvasView(viewModel: viewModel, canvasView: canvasView)
//                                    .frame(width: 240, height: 240)
//                                    .padding()
//                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
//                            }.border(Color.blue)
//                        }
                        
                        CanvasView( pkCanvas: canvasView, toolPicker: toolPicker)
                            .frame(width: 240, height: 240)
                            .padding()
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        
                        
                        Button(action: {
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
                        }, label: {
                            Image("stickIt")
                                .padding()
                                .frame(width: 180, height: 60)
                                .background(Color("lightBlueButtonBG").opacity(0.6))
                                .cornerRadius(32)
                        })
                        
                        //                    Button("Save") {
                        //                        viewModel.saveDrawing()
                        //
                        //                        let drawing = canvasView.drawing
                        //                        let image = drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
                        //
                        //                        // let data = image.pngData()
                        //
                        //                        print(">>>> 1", drawing.bounds, canvasView.bounds)
                        //                        guard let data = image.pngData() else { return }
                        //
                        //                        print(">>>> 2")
                        //
                        //                        guard let pngImage = UIImage(data: data) else { return }
                        //
                        //                        print(">>>> 3")
                        //                        viewModel.savedDrawing = image
                        //
                        //                        print(viewModel.savedDrawing)
                        //                    }
                        
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

                        Spacer()
                        
                        // footer
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: ScribbleView().navigationBarBackButtonHidden(true)) {
                                VStack {
                                    Image("textIconLine")
                                    Text("Text")
                                        .font(.footnote)
                                        .foregroundColor(.black)

                                }
                                .padding()
                            }
                            
                            Spacer()
                            
                            
                            VStack {
                                Image("scribbleIconFill")
                                Text("Scribble")
                                    .font(.footnote)
                                    .foregroundColor(Color("babyBlue"))
                                    .bold()
                            }
                            .padding()
                            
                            
                            Spacer()
                        }
                        .padding(10)
                        .padding(.bottom, 0)
                        .background(Color.white.opacity(0.5).ignoresSafeArea())
                    }
                }
            }
            
        }
        
        
    }
}

#Preview {
    ScribbleView()
}
