//
//  ContentView.swift
//  StickAroundUI
//
//  Created by Lily Yu on 11/30/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("lightYellow")
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("title")
                        .padding()
                    Spacer()
                    
                    NavigationLink(destination: InboxView().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("Inbox")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                            Spacer()
                            Image(systemName: "envelope.badge")
                                .foregroundColor(.black)
                                .padding()
                        }
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(28)
                    }
                    .padding()
                    
                    NavigationLink(destination: ComposeView(viewModel: viewModel).navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("Compose")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                            Spacer()
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.black)
                                .padding()
                        }
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(28)
                    }
                    .padding()
                    
//                    CustomButton(label: "Inbox", systemImage: "envelope.badge")
//                    CustomButton(label: "Compose", systemImage: "square.and.pencil")
                    
                    
                }
                .padding(.bottom, 60)
            }
            
        }
    }
}

struct CustomButton: View {
    let label: String
    let systemImage: String
    
    var body: some View {
        Button(action: {
            print("\(label) button tapped")
        }) {
            HStack {
                Text(label)
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()
                Spacer()
                Image(systemName: systemImage)
                    .foregroundColor(.black)
                    .padding()
            }
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.white.opacity(0.75))
            .cornerRadius(28)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
