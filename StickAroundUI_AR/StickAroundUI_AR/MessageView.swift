//
//  MessageView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

import SwiftUI
import PencilKit

struct MessageView: View {
//    @StateObject var viewModel: ViewModel
    @Binding var message: Message

    @State var pkCanvas = PKCanvasView()
    @State var toolPicker: PKToolPicker? = PKToolPicker()

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack() {
                    Text("✉️ \(message.sender)")
                        .bold()
                        .foregroundStyle(message.fontColor)
                        .font(.system(size: floor(message.fontSize)))
                    Spacer()
    //                Text(message.time)
    //                    .font(.subheadline)
    //                Text("Location: \(message.location)")
                    
                }
                .padding(40)
    //            Spacer()
                Text(message.text)
                    .foregroundStyle(message.fontColor)
                    .padding(40)
                    .font(.system(size: floor(message.fontSize)))
            }
            .padding(300)
            .frame(width: 2000, height: 2000)
            .background(RoundedRectangle(cornerRadius: 200).fill(message.backgroundColor.opacity(0.85)).shadow(radius: 100))
            .border(Color.red, width: 4)
            
            CanvasView(pkCanvas: pkCanvas, toolPicker: toolPicker).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 10)
        }
    }

}

struct Message {
    var sender: String
    var text: String  // TODO: test with longer text
    var location: String
    var time: String
    var backgroundColor: Color
    var fontColor: Color
    var fontSize: CGFloat
}

//#Preview {
//    MessageView(message: .constant(Message()))
//}
