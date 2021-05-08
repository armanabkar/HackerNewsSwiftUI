//
//  ContentView.swift
//  HackerNewsSwiftUI
//
//  Created by Arman Abkar on 5/4/21.
//

import SwiftUI
import SwiftUIRefresh

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    @State private var isShowing = false
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text("\(String(post.points))\nPoint")
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
            .pullToRefresh(isShowing: $isShowing) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.networkManager.fetchData()
                    self.isShowing = false
                }
            }
        }
        .onAppear {
            self.networkManager.fetchData()
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
