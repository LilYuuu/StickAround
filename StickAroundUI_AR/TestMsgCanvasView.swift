//
//  TestMsgCanvasView.swift
//  StickAroundUI_AR
//
//  Created by Lily Yu on 12/10/23.
//

import SwiftUI

struct TestMsgCanvasView: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { geometry in
            MessageView(message: $viewModel.message)
                .frame(width: geometry.size.width, height: geometry.size.width)
                .scaleEffect(geometry.size.width / 2048 / 1.5) // TODO: magic number?
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    TestMsgCanvasView(viewModel: ViewModel())
}
