//
//  ContentView.swift
//  HackerNews
//
//  Created by Arman Abkar on 5/4/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    @State private var showInfoView = false
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text("\(String(post.points))")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .rotationEffect(.degrees(90))
                        Divider()
                        Text(post.title)
                            .font(.title3)
                    }
                }
            }
            .padding(.top, 8.0)
            .navigationTitle(Text("Hacker News"))
            .toolbar {
                Button {
                    showInfoView.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                }

            }
            .background(Color("PrimaryOrange"))
        }
        .accentColor(.white)
        .navigationBarColor(backgroundColor: .clear,
                            titleColor: .white)
        .task {
            try? await networkManager.fetchData()
        }
        .refreshable {
            try? await networkManager.fetchData()
        }
        .alert(isPresented: $networkManager.showAlert) { () -> Alert in
            Alert(title: Text("Error"),
                  message: Text("Sorry, there was a problem with your request."),
                  primaryButton: .default(Text("Try Again")) {
                Task.init { try? await networkManager.fetchData() }
            },
                  secondaryButton: .cancel(Text("Cancel")))
        }
        .sheet(isPresented: $showInfoView) {
            InfoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
