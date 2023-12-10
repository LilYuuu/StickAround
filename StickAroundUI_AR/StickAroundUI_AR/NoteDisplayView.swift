//
//  NoteDisplayView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

struct NoteDisplayView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            ARViewContainer(viewModel: viewModel).edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    NoteDisplayView()
}
