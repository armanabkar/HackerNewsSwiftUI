//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Arman Abkar on 5/4/21.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var showAlert = false
    @Published var showInfoView = false
    @Published var searchText = ""
    
    let algoliaURL = "https://hn.algolia.com/api/v1/search?tags=front_page"
    
    func fetchData() async throws {
        guard let url = URL(string: algoliaURL) else {
            self.showAlert = true
            return
        }
        
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            self.showAlert = true
            return
        }
        let results = try JSONDecoder().decode(Results.self, from: data)
        
        DispatchQueue.main.async { self.posts = results.hits }
    }
    
    var searchResults: [Post] {
        let searchedResults = Array(posts)
        guard !searchText.isEmpty else { return searchedResults }
        return searchedResults.filter { $0.title.contains(searchText) }
    }
}
