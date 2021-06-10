//
//  NetworkManager.swift
//  HackerNewsSwiftUI
//
//  Created by Arman Abkar on 5/4/21.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var isLoading = true

    let algoliaURL = "https://hn.algolia.com/api/v1/search?tags=front_page"
    
    func fetchData() {
        self.isLoading = true
        
        if let url = URL(string: algoliaURL) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            
                            DispatchQueue.main.async { self.posts = results.hits }
                            self.isLoading = false
                        } catch {
                            print(error)
                            self.isLoading = false
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
