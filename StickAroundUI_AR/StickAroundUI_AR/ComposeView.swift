//
//  ComposeView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI
import PencilKit


struct ComposeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: ViewModel

    let locations = ["Wall", "Window", "Ceiling", "Table", "Floor"]
    @State private var locationSelection = "Wall"
    
    
//    @State var canvasView = PKCanvasView()
//    @State var toolPicker: PKToolPicker? = PKToolPicker()
    
//    @State var listScrollingEnabled = true
    
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
                            Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                                Text("Back")
                                    .foregroundStyle(Color.black)
                            }
                            Spacer()
                            Text("Composing...")
                                .bold()
                                .font(.title3)
                                .frame(alignment: .center)
                            Spacer()
//                            NavigationLink(destination: ScribbleView().navigationBarBackButtonHidden(true)) {
//                                Text("Next").foregroundStyle(Color.black)
//                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.75).ignoresSafeArea())
                        
                        // body
                        List {
                            Section {
                                TextField("Name", text: $viewModel.message.sender) {
                                }
                                TextField("Leave your message here", text: $viewModel.message.text) {
                                }
                                .frame(height: 60, alignment: .top)
                            }
                            
                            Section(header: Text("Where to stick the note?").bold().foregroundStyle(Color.black).font(.body)) {
                                Picker("", selection: $locationSelection) {
                                    ForEach(locations, id: \.self) {
                                        Text($0)
                                    }
                                }
//                                  .labelsHidden()
                                .pickerStyle(.menu)
                            }
                            .headerProminence(.increased)

                            Section() {
                                HStack {
                                    Text("Background Color").bold().foregroundStyle(Color.black)
                                    ColorPicker("", selection: $viewModel.message.backgroundColor)
                                }
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
//                            .listSectionSpacing(.compact)
                            
                            Section() {
                                HStack {
                                    Text("Font Color").bold().foregroundStyle(Color.black)
                                    ColorPicker("", selection: $viewModel.message.fontColor)
                                }
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
                            .listSectionSpacing(.compact)
                            
                            Section() {
                                HStack {
                                    Text("Font Size").bold().foregroundStyle(Color.black)
                                    Spacer()
                                    Slider(value: $viewModel.message.fontSize, in: 10...500).frame(width: geometry.size.width * 0.4)
                                }
                                
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
                            .listSectionSpacing(.compact)
                            
                            HStack {
                                Spacer()
                                MessageView(message: $viewModel.message)
                                    .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
                                    .scaleEffect(geometry.size.width / 2048 / 1.5) // TODO: magic number?
//                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                Spacer()
                            }
//                            .listRowBackground(Color.clear)
//                            .border(.blue)
                            .listRowSpacing(0)
                            
                            HStack {
                                Spacer()
                                Button(action: {
//                                    viewModel.saveDrawing()
                                    
//                                    let drawing = canvasView.drawing
//                                    let image = drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
//                                    
//                                    // let data = image.pngData()
//                                    
//                                    print(">>>> 1", drawing.bounds, canvasView.bounds)
//                                    guard let data = image.pngData() else { return }
//                                    
//                                    print(">>>> 2")
//                                    
//                                    guard let pngImage = UIImage(data: data) else { return }
//                                    
//                                    print(">>>> 3")
//                                    viewModel.savedDrawing = image
//                                    
//                                    print(viewModel.savedDrawing)
                                }, label: {
                                    Image("stickIt")
                                        .padding()
                                        .frame(width: 180, height: 60)
                                        .background(Color("lightBlueButtonBG").opacity(0.6))
                                        .cornerRadius(32)
                                })
                                Spacer()
                                
                            }
                            .listRowBackground(Color.clear)
                            
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
                            
                            
                        }
                        .scrollContentBackground(.hidden)
//                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .disabled(!viewModel.listScrollingEnabled)
                        
                        Spacer()
                        
                        
                        // footer
//                        HStack {
//                            Spacer()
//                            
//                            VStack {
//                                Image("textIconFill")
//                                Text("Text")
//                                    .font(.footnote)
//                                    .foregroundColor(Color("babyBlue"))
//                                    .bold()
//                            }
//                            .padding()
//                            
//                            Spacer()
//                            
//                            NavigationLink(destination: ScribbleView().navigationBarBackButtonHidden(true)) {
//                                VStack {
//                                    Image("scribbleIconLine")
//                                    Text("Scribble")
//                                        .font(.footnote)
//                                        .foregroundStyle(Color.black)
//                                }
//                                .padding()
//                            }
//                            
//                            Spacer()
//                        }
//                        .padding(10)
//                        .padding(.bottom, 0)
//                        .background(Color.white.opacity(0.5).ignoresSafeArea())
                    }
                }
            }
        }
    }
}


#Preview {
    ComposeView(viewModel:ViewModel())
}
