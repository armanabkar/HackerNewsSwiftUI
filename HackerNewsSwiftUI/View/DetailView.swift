//
//  DetailView.swift
//  HackerNewsSwiftUI
//
//  Created by Arman Abkar on 5/4/21.
//

import SwiftUI

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
            .navigationBarColor(backgroundColor: UIColor(named: "PrimaryOrange"),
                                titleColor: .white)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}
