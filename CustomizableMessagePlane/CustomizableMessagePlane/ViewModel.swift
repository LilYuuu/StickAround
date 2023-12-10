//
//  ViewModel.swift
//  CustomizableMessagePlane
//
//  Created by Lily Yu on 11/9/23.
//

import Foundation
import Combine
import SwiftUI

class ViewModel: ObservableObject {
    enum Mode {
        case editing
        case viewing
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var message: Message = Message()
    @Published var mode: Mode = .viewing
    
    @Published var testUIImage: UIImage?
    
    // Single pass through subject ("signal") for resetting the view.
    var resetSignal: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
}

struct Message {
    var sender: String = "Lily"
    var text: String = "Testing testing"  // TODO: test with longer text
    var location: String = "Wall"
    var time: String = "2023-10-25 15:22:42"
    var fontSize: CGFloat = 200
    var backgroundColor: Color = .black
}
