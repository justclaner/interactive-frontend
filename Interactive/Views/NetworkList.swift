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
    @Binding var path: [String]
    
    let xIconSize = Control.getScreenSize().width * 0.05
    let xIconCircleWidth = Control.getScreenSize().width * 0.06
    
    @State var linkClicked: Bool = false
    
    @StateObject var networkLinks = NetworkLinks()
    var body: some View {
        HStack {
            ForEach(0..<networkLinks.links.count, id: \.self) {index in
                ZStack {
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
                    Image("x-icon")
                        .resizable()
                        .frame(width:xIconSize, height:xIconSize)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .opacity(0.5)
                                .frame(width: xIconCircleWidth, height: xIconCircleWidth)
                        )
                        .offset(x: (xIconSize + xIconCircleWidth * 0.9) / 2, y: -(xIconSize + xIconCircleWidth * 0.9) / 2)
                        .onTapGesture {
                            linkClicked = true
                        }
                        .confirmationDialog("deleteLink\(index)", isPresented: $linkClicked) {
                            Button("Delete Link") {
                                print("delete")
                                Task {
                                    do {
                                        let response = try await APIClient.deleteUserSocialMediaLink(linkURL: networkLinks.links[index])
                                        print(response)
                                        if (response.success) {
                                            networkLinks.updateLinks()
                                        }
                                    } catch {
                                        print(error)
                                    }
                                }
                            }
                            Button("Change Link") {
                                UserDefaults.standard.set(networkLinks.links[index], forKey: "tempNetworkLink")
                                path.append("Edit Network")
                            }
                        }
                }
            }
            }
        .onAppear {
            networkLinks.updateLinks()
        }
        }
    }

#Preview {
    NetworkList(path: .constant(["test"]))
}
