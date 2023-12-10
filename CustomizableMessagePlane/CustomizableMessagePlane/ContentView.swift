//
//  ContentView.swift
//  CustomizableMessagePlane
//
//  Created by Lily Yu on 11/9/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            ARViewContainer(viewModel: viewModel).edgesIgnoringSafeArea(.all)
            
            HUDView(viewModel: viewModel)
            
            if let testUIImage = viewModel.testUIImage {
                Image(uiImage: testUIImage)
                    .resizable()
            }
            
        }
        .sheet(isPresented: .constant(viewModel.mode == .editing),
               onDismiss: dismissSheet) {
            EditingView(viewModel: viewModel)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationBackground(.ultraThinMaterial)
        }
    }
    
    func dismissSheet() {
        viewModel.mode = .viewing
    }
}


#Preview {
    ContentView()
}
