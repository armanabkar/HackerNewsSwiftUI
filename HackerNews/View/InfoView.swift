//
//  InfoView.swift
//  HackerNews
//
//  Created by Arman Abkar on 6/8/22.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        List {
            Section {
            } footer: {
                VStack {
                    HStack {
                        Spacer()
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .padding(.bottom)
                        Spacer()
                    }
                    Text("Hacker News is a social news website focusing on computer science and entrepreneurship. It is run by the investment fund and startup incubator Y Combinator. In general, content that can be submitted is defined as 'anything that gratifies one's intellectual curiosity'.")
                        .font(.body)
                }
            }
            .multilineTextAlignment(.center)
            
            Section {
                HStack {
                    Text("Version")
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(appVersion)
                }
                HStack {
                    Text("Developer")
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Arman Abkar")
                }
                HStack {
                    Text("Website")
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("[armanabkar.ir](https://armanabkar.ir)")
                }
            } header: {
                Text("App Information")
            } footer: {
                Text("This app is built with SwiftUI and Algolia HN Search API.")
            }
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
