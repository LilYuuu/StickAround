//
//  EditingView.swift
//  CustomizableMessagePlane
//
//  Created by Lily Yu on 11/9/23.
//

// Code example for EditingView: https://github.com/augmentedhacking/dynamic-textures

import SwiftUI

struct EditingView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                TextField("Enter text", text: $viewModel.message.text)
                    .foregroundColor(.white)
                    .padding()
                
                Divider()
                
                HStack {
                    Slider(value: $viewModel.message.fontSize, in: 10...500)
                    
                    Text("\(String(format: "%.0f", floor(viewModel.message.fontSize)))")
                }
                
                ColorPicker("Background", selection: $viewModel.message.backgroundColor)
//                ColorPicker("Foreground", selection: $viewModel.message.foregroundColor)
                
                
                GeometryReader { geometry in
                    MessageView(message: $viewModel.message)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .scaleEffect(geometry.size.width / 2048) // TODO: magic number?
                }
                
                Divider()
                
                
            }
        }
        .padding()
    }
}

#Preview {
    EditingView(viewModel: ViewModel())
}
