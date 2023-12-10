//
//  ComposeView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

struct ComposeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var viewModel: ViewModel

    let locations = ["Wall", "Window", "Ceiling", "Table", "Floor"]
    @State private var locationSelection = "Wall"
    
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
                            NavigationLink(destination: ScribbleView().navigationBarBackButtonHidden(true)) {
                                Text("Next").foregroundStyle(Color.black)
                            }
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
                                Spacer()
                            }
                            .listRowBackground(Color.clear)
                            .border(.blue)
                        }
                        .scrollContentBackground(.hidden)
                        
                        Spacer()
                        
                        // footer
                        HStack {
                            Spacer()
                            
                            VStack {
                                Image("textIconFill")
                                Text("Text")
                                    .font(.footnote)
                                    .foregroundColor(Color("babyBlue"))
                                    .bold()
                            }
                            .padding()
                            
                            Spacer()
                            
                            NavigationLink(destination: ScribbleView().navigationBarBackButtonHidden(true)) {
                                VStack {
                                    Image("scribbleIconLine")
                                    Text("Scribble")
                                        .font(.footnote)
                                        .foregroundStyle(Color.black)
                                }
                                .padding()
                            }
                            
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
    ComposeView(viewModel:ViewModel())
}
