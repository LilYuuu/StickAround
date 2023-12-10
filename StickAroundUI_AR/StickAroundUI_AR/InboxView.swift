//
//  InboxView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

struct InboxView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let testMsg = Message(sender: "El", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sodales posuere augue mollis posuere. Curabitur lectus massa, suscipit vitae malesuada in, ultrices quis nulla.", location: "Ceiling", time: "2023-10-25 15:22:42", backgroundColor: .yellow, fontColor: .white, fontSize: 200)

    var body: some View {
        NavigationView {
            ZStack {
                Color("lightYellow")
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                                Text("Home")
                                .foregroundStyle(Color.black)
                            }
                        Spacer()
                        Text("Inbox")
                            .bold()
                            .font(.title3)
                            .frame(alignment: .center)
                            
                        Spacer()
                        NavigationLink(destination: NoteDisplayView()) {
                            Text("Display All")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.75).ignoresSafeArea())

                    List {
                        Section(header: Text("Unread").bold().foregroundStyle(Color.black).font(.subheadline)) {
                            UnreadMessageItem(message: testMsg)
                        }.headerProminence(.increased)
                            .listRowBackground(Color("lightBlueButtonBG").opacity(0.4))
                        
                        
                        Section(header: Text("All").bold().foregroundStyle(Color.black).font(.subheadline)) {
                                MessageItem(message: testMsg)
                                MessageItem(message: testMsg)
                                MessageItem(message: testMsg)
                        }.headerProminence(.increased)
//                        Section {
//                            MessageItem(timeStamp: "Time", location: "Location", message: "Message")
//                        }
//                        
//                        Section {
//                            MessageItem(timeStamp: "Time", location: "Location", message: "Message")
//                        }
                    }
                    .scrollContentBackground(.hidden)
                    Spacer()
                }
//                .padding()
            }
        }
    }
}

struct MessageItem: View {
//    let timeStamp: String
//    let location: String
//    let message: String
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(message.time)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                Spacer()
                Text(message.location)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            Text(message.sender)
                .bold()
            Text(message.text)
                .padding(.top, 5)
                .padding(.bottom, 5)
        }.padding()
    }
}

struct UnreadMessageItem: View {
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(message.time)
                    .font(.caption)
//                    .foregroundStyle(Color.gray)
                Spacer()
            }
            
            Spacer()
            Text("**\(message.sender)** sticked a new note on your **\(message.location)**")
//            Text(message.text)
                .padding(.top, 5)
                .padding(.bottom, 5)
        }.padding()
    }
}

#Preview {
    InboxView()
}
