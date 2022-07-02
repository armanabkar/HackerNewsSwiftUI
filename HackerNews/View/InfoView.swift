//
//  InfoView.swift
//  HackerNews
//
//  Created by Arman Abkar on 6/8/22.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.15)
                .ignoresSafeArea()
            
            VStack(spacing: 35) {
                Capsule()
                    .frame(width: 120, height: 6)
                    .foregroundColor(Color.secondary)
                    .opacity(0.25)
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, alignment: .center)
                
                Text("Hacker News is a social news website focusing on computer science and entrepreneurship. It is run by the investment fund and startup incubator Y Combinator. In general, content that can be submitted is defined as 'anything that gratifies one's intellectual curiosity'.")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text("This app is built with SwiftUI and Algolia HN Search API.")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 10) {
                    Text(appVersion)
                        .fontWeight(.medium)
                    
                    Text("Developed by Arman Abkar")
                        .fontWeight(.medium)
                }
                .font(.title3)
                .foregroundColor(.secondary)
            }
            .padding(20)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    private var appVersion: String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "\(version) (\(build))"
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
