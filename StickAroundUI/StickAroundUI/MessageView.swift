//
//  MessageView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

import SwiftUI

struct MessageView: View {
    @Binding var message: Message
//    let message: Message

    var body: some View {
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
            
    }
}

//#Preview {
//    MessageView(message: .constant(Message()))
//}
