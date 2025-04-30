//
//  ProfileCard.swift
//  Interactive
//
//  Created by Justin Zou on 3/11/25.
//

import SwiftUI

struct ProfileCard: View {
    
   // @Binding var path: [String]
    @Binding var userId: String
   // @State var userId: String
    @State var profileImageUrl: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg"
    @State var username: String = ""
    @State var bio: String = ""
    @State var networkLinks: [String] = []
    
//    init(path: Binding<[String]>) {
//        self._path = path
//        self._userId = State(initialValue:
//        (path.wrappedValue.last != nil && path.wrappedValue.last!.count > 13)
//            ? String(path.wrappedValue.last!.dropFirst(13))
//            : ""
//        )
//    }
    
    let imageSquareWidth = Control.maxWidth * 0.4
    let cardWidth = Control.maxWidth * 0.46
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url:URL(string:profileImageUrl)) {phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(width: imageSquareWidth, height: imageSquareWidth)
                        .clipShape(
                            RoundedRectangle(cornerRadius: Control.mediumFontSize)
                        )
                } else {
                    RoundedRectangle(cornerRadius: Control.mediumFontSize)
                        .fill(Color.gray)
                        .frame(width: imageSquareWidth, height: imageSquareWidth)
                }
            }
            .task(id: profileImageUrl) {
                
            }
            .padding([.top], (cardWidth - imageSquareWidth) / 2)
            Text(username)
                .font(.system(size: Control.mediumFontSize, weight: .bold))
                .frame(width: imageSquareWidth, alignment: .leading)
            if (!bio.isEmpty) {
                Text(bio)
                    .font(.system(size: Control.tinyFontSize, weight: .semibold))
                    .frame(width: imageSquareWidth, alignment: .leading)
            }

            ProfileNetworks(networkLinks: $networkLinks, iconWidth: .constant(CGFloat(Control.getScreenSize().width * 0.12437810945)))
                .padding([.bottom], 0.5 * Control.tinyFontSize)
                .padding([.leading, .trailing], (cardWidth - imageSquareWidth) / 2)
        }
        .frame(width: cardWidth)
        .background(
            RoundedRectangle(cornerRadius: Control.mediumFontSize)
                .stroke(Control.hexColor(hexCode: "#9A9A9A"))
                .fill(Control.hexColor(hexCode: "#9A9A9A"))
        )
        .onTapGesture {
        
           // print(networkLinks);
        }
        .onAppear() {
            Task {
                do {
                    let imageResponse = try await APIClient.fetchUserImages(userId: userId)
                    if (imageResponse.success) {
                        if (imageResponse.images.image1 != nil) {
                            profileImageUrl = imageResponse.images.image1!
                        }
                    }
                    
                    let userResponse = try await APIClient.fetchUser(userId: userId)
                    if (userResponse.success) {
                        if (userResponse.user != nil) {
                            username = userResponse.user!.username
                            bio = userResponse.user!.biography ?? ""
                        }
                    }
                    
                    let networkResponse = try await APIClient.fetchUserNetworksFromId(userId: userId)
                    if (networkResponse.success) {
                        if (networkResponse.socialMediaLinks != nil) {
                            networkLinks = [];
                            networkResponse.socialMediaLinks!.forEach { socialMediaLink in
                                networkLinks.append(socialMediaLink.social_media_url)
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ProfileCard(userId: .constant("67e1f1ebe8357f816722b319"))
}
