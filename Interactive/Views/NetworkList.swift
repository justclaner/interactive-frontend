//
//  NetworkLinks.swift
//  Interactive
//
//  Created by Justin Zou on 2/23/25.
//

import SwiftUI
@MainActor class NetworkLinks: ObservableObject {
    @Published var links: [String] = []
    
    
    func updateLinks() {
        Task {
            do {
                let response = try await APIClient.fetchUserNetworks()
                var tempLinks: [String] = []
                if (response.socialMediaLinks != nil) {
                    response.socialMediaLinks!.forEach {
                        link in
                        tempLinks.append(link.social_media_url)
                    }
                }
                links = tempLinks
            } catch {
                print(error)
            }
        }
    }
}

struct NetworkList: View {
    @StateObject var networkLinks = NetworkLinks()
    var body: some View {
        HStack {
            ForEach(0..<networkLinks.links.count, id: \.self) {index in
                Link(destination: URL(string: networkLinks.links[index])!) {
                    Image((String(Control.getDomainHost(from: networkLinks.links[index])!.dropFirst(4).dropLast(4))
                          ))
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width:CGFloat(Control.getScreenSize().width * 0.12437810945),
                            height:CGFloat(Control.getScreenSize().width * 0.12437810945),
                            alignment: .center)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: Control.getScreenSize().width * 0.03233830845))
                }
            }
            }
        .onAppear {
            networkLinks.updateLinks()
        }
        }
    }

#Preview {
    NetworkList()
}
