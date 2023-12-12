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
    
    
    @State var pkCanvas = PKCanvasView()
    @State var toolPicker: PKToolPicker? = PKToolPicker()
    
    @State private var isDrawingSaved = false
    
    @ObservedObject private var keyboard = KeyboardResponder()
        
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
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
                                // reset message
                                viewModel.message = Message(sender: "", text: "", location: "Wall", time: "", backgroundColor: .yellow, fontColor: .white, fontSize: 200)
                                
                                // reset PK canvas
                                pkCanvas.drawing = PKDrawing()
                                
                            }) {
                                Text("Back")
                                    .foregroundStyle(Color.black)
                            }
                            Spacer()
                            Text("Composing...")
                                .bold()
                                .font(.title3)
                                .frame(alignment: .center)
                            Spacer()
                            Button(action: {
                                pkCanvas.drawing = PKDrawing()
                                viewModel.message.drawing = UIImage()
                                print("Drawing cleared")
                            }, label: {
                                Text("Clear")
                                    .foregroundStyle(Color.black)
                            })
                        }
                        .padding()
                        .background(Color.white.opacity(0.75).ignoresSafeArea())
                        
                        // body
                        Text("Draw here!").bold().foregroundStyle(Color.black).font(.body).padding(.top, 12)
                        
                        HStack {
                            Spacer()
                            ZStack {
                                MessageView(message: $viewModel.message)
                                    .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                                    .scaleEffect(geometry.size.width / 2048 / 1.5) // TODO: magic number?
                                CanvasView(pkCanvas: pkCanvas, toolPicker: toolPicker)
                                    .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                            }
                            .onTapGesture {
                                ShowToolPicker(toShow: true)
                            }
                            
                            
                            Spacer()
                        }
                        .padding()
                        
                        List {
                            Section(header: Text("Type here!").bold().foregroundStyle(Color.black).font(.body).padding(.top, 12)) {
                                TextField("Name", text: $viewModel.message.sender)
                                TextField("Leave your message here", text: $viewModel.message.text, axis: .vertical)
                                .frame(height: 60, alignment: .top)
                            }
                            .headerProminence(.increased)
                            .onTapGesture {
//                                if let toolPicker = toolPicker {
//                                    toolPicker.setVisible(false, forFirstResponder: pkCanvas)
//                                    toolPicker.removeObserver(pkCanvas)
//                                    pkCanvas.resignFirstResponder()
//                                }
                                ShowToolPicker(toShow: false)
                            }
                            
                            
                            Section(header: Text("Where to stick the note?").bold().foregroundStyle(Color.black).font(.body)) {
                                Picker("", selection: $viewModel.message.location) {
                                    ForEach(locations, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                            .headerProminence(.increased)
                            .onTapGesture {
                                ShowToolPicker(toShow: false)
                            }
                            
                            Section() {
                                HStack {
                                    Text("Background Color").bold().foregroundStyle(Color.black)
                                    ColorPicker("", selection: $viewModel.message.backgroundColor)
                                }
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                ShowToolPicker(toShow: false)
                            }
                            
                            Section() {
                                HStack {
                                    Text("Font Color").bold().foregroundStyle(Color.black)
                                    ColorPicker("", selection: $viewModel.message.fontColor)
                                }
                            }
                            .headerProminence(.increased)
                            .listRowBackground(Color.clear)
                            .listSectionSpacing(.compact)
                            .onTapGesture {
                                ShowToolPicker(toShow: false)
                            }
                            
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
                            .onTapGesture {
                                ShowToolPicker(toShow: false)
                            }
                            
                            HStack {
                                Spacer()
                                ZStack {
                                    Button(action: {
                                        let drawing = pkCanvas.drawing
                                        let image = drawing.image(from: pkCanvas.bounds, scale: UIScreen.main.scale)
                                                                                
                                        print(">>>> 1", drawing.bounds, pkCanvas.bounds)
                                        guard let data = image.pngData() else { return }
                                        
                                        print(">>>> 2")
                                        
                                        guard let pngImage = UIImage(data: data) else { return }
                                        
                                        print(">>>> 3")
//                                        viewModel.savedDrawing = image
                                        viewModel.message.drawing = image
                                
                                        print("saved drawing in message: \(viewModel.message.drawing)")
                                        
                                        isDrawingSaved = true
                                    }, label: {
                                        Image("stickIt")
                                            .padding()
                                            .frame(width: 180, height: 60)
                                            .background(Color("lightBlueButtonBG").opacity(0.6))
                                            .cornerRadius(32)
                                    })
                                    NavigationLink(destination: NoteDisplayView(viewModel: viewModel), isActive: $isDrawingSaved) {EmptyView()}.hidden()
                                }
                            }
                            .listRowBackground(Color.clear)
                            
//                            ZStack {
//                                if let drawing = viewModel.message.drawing {
//                                    Image(uiImage: drawing).scaledToFit()
//                                        .border(.blue)
//                                }
//                                
//                            }
//                            .frame(width: 240, height: 240)
//                            .onReceive(viewModel.$savedDrawing, perform: { _ in
//                                print("Drawing updated")
//                            })
                            
                            ////            Spacer()
                            //            Image(uiImage: viewModel.savedDrawing)
                            //                .frame(width: 300, height: 300)
                            //                            Text("Scribble saved")
                            
                            
                        }
                        .background(.white.opacity(0.5))
                        .scrollContentBackground(.hidden)
                        .padding(.bottom, keyboard.currentHeight)
                        .edgesIgnoringSafeArea(.bottom)
                        .animation(.easeOut(duration: 0.16))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func ShowToolPicker(toShow: Bool) {
        if let toolPicker = toolPicker {
            toolPicker.setVisible(toShow, forFirstResponder: pkCanvas)
            if toShow {
                toolPicker.addObserver(pkCanvas)
                pkCanvas.becomeFirstResponder()
            } else {
                toolPicker.removeObserver(pkCanvas)
                pkCanvas.resignFirstResponder()
            }
            
        }
    }
}

final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}

#Preview {
    ComposeView(viewModel:ViewModel())
}
