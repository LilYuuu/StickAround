//
//  NoteDisplayView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

struct NoteDisplayView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var viewModel: ViewModel
    
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            ARViewContainer(viewModel: viewModel).edgesIgnoringSafeArea(.all)
                .onAppear{
                    showingAlert = true
                }
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Tap on a plane to stick the note!"), dismissButton: Alert.Button.default(Text("OK")))
                })
            
            VStack {
                ZStack {
                    HStack {
                        Text("Display")
                        .bold()
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    .background(Color.white.opacity(0.75).ignoresSafeArea())
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            viewModel.message = Message(sender: "", text: "", location: "Wall", time: "", backgroundColor: .yellow, fontColor: .white, fontSize: 200)
                        }) {
                            Text("Back")
                            .foregroundStyle(Color.black)
                        }
                        Spacer()
                    }.padding()
                }
                
                Spacer()
            }
            
            
            
//            Text("TESTING TEXT")
            
//            if let drawing = viewModel.message.drawing {
//                Image(uiImage: drawing).resizable().frame(width: 200, height: 200)
//            } else {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//            }
        }.navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    NoteDisplayView(viewModel: ViewModel())
}
