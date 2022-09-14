//
//  ContentView.swift
//  HackerNews
//
//  Created by Arman Abkar on 5/4/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(vm.searchResults, id: \.id) { post in
                        NavigationLink(destination: DetailView(url: post.url)) {
                            HStack {
                                Text("\(String(post.points))")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.center)
                                    .rotationEffect(.degrees(90))
                                Divider()
                                Text(post.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Hacker News"))
            .toolbar {
                Button {
                    vm.showInfoView.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.black)
                }
            }
        }
        .searchable(text: $vm.searchText)
        .task {
            try? await vm.fetchData()
        }
        .refreshable {
            try? await vm.fetchData()
        }
        .alert(isPresented: $vm.showAlert) { () -> Alert in
            Alert(title: Text("Error"),
                  message: Text("Sorry, there was a problem with your request."),
                  primaryButton: .default(Text("Try Again")) {
                Task.init { try? await vm.fetchData() }
            },
                  secondaryButton: .cancel(Text("Cancel")))
        }
        .sheet(isPresented: $vm.showInfoView) {
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
