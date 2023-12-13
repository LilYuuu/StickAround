//
//  InboxView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

struct InboxView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var viewModel: ViewModel
    
    @State var newMessage: Message?
    
    let testMsg = Message(sender: "El", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sodales posuere augue mollis posuere. Curabitur lectus massa, suscipit vitae malesuada in, ultrices quis nulla.", location: "Wall", time: "2023-10-25 15:22:42", backgroundColor: .yellow, fontColor: .white, fontSize: 200)

    var body: some View {
        NavigationView {
            ZStack {
                Color("lightYellow")
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        HStack {
                            Text("Inbox")
                                .bold()
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        .background(Color.white.opacity(0.75).ignoresSafeArea())
                        HStack {
                            Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                                    Text("Home")
                                    .foregroundStyle(Color.black)
                                }
                            
                            Spacer()
                            
                            NavigationLink(destination: NoteDisplayView(viewModel: viewModel).navigationBarBackButtonHidden(true)) {
                                Text("Display All")
                                    .foregroundStyle(Color.black)
                            }
                        }
                        .padding()
                        
                    }
                    
                    

                    List {
                        if let lastMsgInArray = viewModel.messages.last {
                            if (lastMsgInArray != newMessage) {
//                                newMessage = lastMsgInArray
                                Section(header: Text("Unread").bold().foregroundStyle(Color.black).font(.body)) {
                                    UnreadMessageItem(message: lastMsgInArray, viewModel: viewModel)
                                }.headerProminence(.increased)
                                    .listRowBackground(Color("accentYellow"))
                            } else {
                                // for debug
                                Text("last msg in array: \(lastMsgInArray.text)")
                                Text("last unread: \(newMessage!.text)")
                            }
                        }
                        
                        
                        Section(header: Text("All").bold().foregroundStyle(Color.black).font(.body)) {
//                            MessageItem(message: testMsg, viewModel: viewModel)
//                            MessageItem(message: testMsg, viewModel: viewModel)
//                            MessageItem(message: testMsg, viewModel: viewModel)
                            let msgArray = viewModel.messages
                            if !msgArray.isEmpty {
                                if (msgArray.first != newMessage) {
                                    ForEach(msgArray, id: \.self) { eachMsg in
                                        MessageItem(message: eachMsg, viewModel: viewModel)
                                    }
                                }
                            }
                        }.headerProminence(.increased)
                            .listRowBackground(Color.white.opacity(0.7))
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
    let viewModel: ViewModel
    
    var body: some View {
//        NavigationLink(destination: NoteDisplayView(viewModel: viewModel, message: message)) {
//        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(message.time)
                            .font(.footnote)
                            .foregroundStyle(Color.gray)
                        Spacer()
                        Text(message.location)
                            .font(.footnote)
                            .foregroundStyle(Color.gray)
                    }
                    
                    Spacer()
                    Text(message.sender)
                        .bold()
                    Text(message.text)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                }.padding()
                
                Button(action: {
                    viewModel.message = message
                    print(viewModel.message)
                }, label: { Text("") })
                .background(
                    NavigationLink(
                        destination: NoteDisplayView(viewModel: viewModel),
                        label: { EmptyView() }
                    ).opacity(0)
                )
                
//                NavigationLink(destination: NoteDisplayView(viewModel: viewModel)) {EmptyView()}.opacity(0)
//                    .onTapGesture {
//                        viewModel.message = message
//                }
            }
//        }
        
            
//        }
    }
}

struct UnreadMessageItem: View {
    let message: Message
    let viewModel: ViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(message.time)
                        .font(.footnote)
    //                    .foregroundStyle(Color.gray)
                    Spacer()
                }
                
                Spacer()
                Text("**\(message.sender)** sticked a new note on your **\(message.location)**")
                
    //            Text(message.text)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
            }.padding()
            
            Button(action: {
                viewModel.message = message
                print(viewModel.message)
            }, label: { Text("") })
            .background(
                NavigationLink(
                    destination: NoteDisplayView(viewModel: viewModel),
                    label: { EmptyView() }
                ).opacity(0)
            )
            
//            NavigationLink(destination: NoteDisplayView(viewModel: viewModel)) {EmptyView()}.opacity(0)
//                .onTapGesture {
//                    viewModel.message = message
//                    print(viewModel.message)
//                }
        }
        
    }
}

#Preview {
    InboxView(viewModel: ViewModel())
}
