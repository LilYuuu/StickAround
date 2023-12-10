//
//  InboxView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

struct InboxView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
                                MessageItem(timeStamp: "Time", location: "", message: "Message")
                        }.headerProminence(.increased)
                        
                        Section(header: Text("All").bold().foregroundStyle(Color.black).font(.subheadline)) {
                                MessageItem(timeStamp: "Time", location: "Location", message: "Message")
                                MessageItem(timeStamp: "Time", location: "Location", message: "Message")
                                MessageItem(timeStamp: "Time", location: "Location", message: "Message")
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
    let timeStamp: String
    let location: String
    let message: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(timeStamp)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                Spacer()
                Text(location)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            
            Text(message)
                .padding(.top, 5)
                .padding(.bottom, 5)
        }
    }
}

#Preview {
    InboxView()
}
