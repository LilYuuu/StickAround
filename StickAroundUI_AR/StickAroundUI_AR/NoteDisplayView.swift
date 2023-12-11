//
//  NoteDisplayView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

struct NoteDisplayView: View {
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
            
//            Text("TESTING TEXT")
            
//            if let drawing = viewModel.message.drawing {
//                Image(uiImage: drawing).resizable().frame(width: 200, height: 200)
//            } else {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//            }
        }
    }
    
}

//#Preview {
//    NoteDisplayView()
//}
