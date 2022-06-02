//
//  ContentView.swift
//  HackerNewsSwiftUI
//
//  Created by Arman Abkar on 5/4/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
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
            .background(Color("PrimaryOrange"))
        }
        .onAppear {
            self.networkManager.fetchData()
        }
        .refreshable {
            self.networkManager.fetchData()
        }
        .alert(isPresented: $networkManager.showAlert) { () -> Alert in
            let primaryButton = Alert.Button.default(Text("Try Again")) {
                self.networkManager.fetchData()
            }
            let secondaryButton = Alert.Button.cancel(Text("Cancel"))
            return Alert(title: Text("Error"),
                         message: Text("Sorry, there was a problem with your request."),
                         primaryButton: primaryButton,
                         secondaryButton: secondaryButton)
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
