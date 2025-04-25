//
//  ProfilePage.swift
//  Interactive
//
//  Created by Justin Zou on 3/18/25.
//

import SwiftUI
import SocketIO

struct ProfilePage: View {
    @Binding var path: [String]
    @State var socket: SocketIOClient = SocketService.shared.socket
    
    @State var userId: String
    @State var username: String = "random username"
    @State var bio: String = "random bio"
    @State var visitors: Int = 0
    @State var interactions: Int = 0
    @State var imageLinks: [String] = []
    @State var networkLinks: [String] = []
    @State var interactStatus: String = "Interact"
//    @State var interactButtonColor: Color = interactStatus == "Interacting" ? Control.hexColor(hexCode: "#FFDD1A"): Color.white.opacity(0.55)
    
    init(path: Binding<[String]>) {
        self._path = path
        self._userId = State(initialValue:
        (path.wrappedValue.last != nil && path.wrappedValue.last?.count ?? 0 > 8)
            ? String(path.wrappedValue.last!.dropFirst(8))
            : ""
        )
    }
    
    let imageSquareWidth = Control.maxWidth * 0.42
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.001)
                .ignoresSafeArea()
                .background(
                    Image("Background1")
                        .resizable()
                        .ignoresSafeArea()
                )
                .onTapGesture {
                    print("test")
                }
            BackButton(path:$path)
                .padding([.top],8)
            VStack(spacing: Control.tinyFontSize) {
                Text(username)
                    .font(.system(size:Control.mediumFontSize, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding([.trailing], Control.smallFontSize)
                
                //profile images
                ScrollView(.horizontal) {
                    HStack(spacing: Control.smallFontSize) {
                        ForEach(0..<imageLinks.count, id: \.self) { index in
                            AsyncImage(url:URL(string:imageLinks[index])) {phase in
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
                        }
                    }
                    .padding([.leading], Control.smallFontSize)
                }
                
                //visitors and interactions
                HStack {
                    VStack {
                        Text("Visitors")
                            .font(.system(size: Control.smallFontSize, weight: .bold))
                            .foregroundStyle(Color.white)
                        Text("\(visitors)")
                            .font(.system(size: Control.mediumFontSize, weight: .bold))
                            .frame(maxWidth: "Visitorss".size(withAttributes: [.font: UIFont.systemFont(ofSize: Control.smallFontSize)]).width, alignment: .leading)
                            .foregroundStyle(Color.white)
                    }
                    //.border(Color.red, width: 2)
                    VStack {
                        Text("Interactions")
                            .font(.system(size: Control.smallFontSize, weight: .bold))
                            .foregroundStyle(Color.white)
                        Text("\(interactions)")
                            .font(.system(size: Control.mediumFontSize, weight: .bold))
                            .frame(maxWidth: "Interactionss".size(withAttributes: [.font: UIFont.systemFont(ofSize: Control.smallFontSize)]).width, alignment: .leading)
                            .foregroundStyle(Control.hexColor(hexCode: "#FFDD1A"))
                    }
                    //.border(Color.red, width: 2)
                    Spacer()
                }
                .padding([.leading], Control.smallFontSize)
                
                //biography
                VStack {
                    Text("About Me")
                        .font(.system(size: Control.tinyFontSize, weight: .bold))
                        .foregroundStyle(Color.white).opacity(0.65)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    Text(bio)
                        .font(.system(size: Control.tinyFontSize, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                .padding([.leading], Control.smallFontSize)
                
                //network
                VStack {
                    Text("Network")
                        .font(.system(size: Control.tinyFontSize, weight: .bold))
                        .foregroundStyle(Color.white).opacity(0.65)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    ProfileNetworks(networkLinks: $networkLinks, iconWidth: .constant(CGFloat(Control.getScreenSize().width * 0.14)))
                        .padding([.top], -0.3 * Control.tinyFontSize)
                }
                .padding([.leading], Control.smallFontSize)
                
                Spacer()
                
                //interact button
                Button(action: {
                    handleSendingInteraction()
                }) {
                    Text(interactStatus)
                        .font(.system(size:1.3 * Control.tinyFontSize,weight:.semibold))
                        .foregroundStyle(interactStatus == "Interacting"
                                         ? Color.black
                                         : Color.white)
                        .padding(Control.tinyFontSize)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:Control.maxWidth, height: Control.mediumHeight)
                .background(interactStatus == "Interacting"
                            ? Control.hexColor(hexCode: "#FFDD1A")
                            : Color.white.opacity(0.55))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
                .padding([.bottom], 0.9 * Control.navigationBarHeight)
            }
            .onAppear {
                //TO-DO: add API calls to increase visitor/interactions
                if (Control.getUserId() != userId) {
                    
                }
                getUserData()
            }
            
            NavigationBar(path: $path)
        }

    }
    func getUserData() {
        getImages()
        
        getTextData()
        
        getNetwork()
        
        handleInteractionStatus()
    }
    
    func getImages() {
        Task {
            do {
                let imageResponse = try await APIClient.fetchUserImages(userId: userId)
                if (imageResponse.success) {
                    if (imageResponse.images.image1 != nil) {
                        imageLinks.append(imageResponse.images.image1!)
                    }
                    if (imageResponse.images.image2 != nil) {
                        imageLinks.append(imageResponse.images.image2!)
                    }
                    if (imageResponse.images.image3 != nil) {
                        imageLinks.append(imageResponse.images.image3!)
                    }
                    if (imageResponse.images.image4 != nil) {
                        imageLinks.append(imageResponse.images.image4!)
                    }
                    if (imageResponse.images.image5 != nil) {
                        imageLinks.append(imageResponse.images.image5!)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getTextData() {
        Task {
            do {
                let userResponse = try await APIClient.fetchUser(userId: userId)
                if (userResponse.success) {
                    if (userResponse.user != nil) {
                        username = userResponse.user!.username
                        bio = userResponse.user!.biography ?? ""
                        visitors = userResponse.user!.visitors ?? 0
                        interactions = userResponse.user!.visitors ?? 0
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getNetwork() {
        Task {
            do {
                let networkResponse = try await APIClient.fetchUserNetworksFromId(userId: userId)
                if (networkResponse.success) {
                    if (networkResponse.socialMediaLinks != nil) {
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
    
    func handleInteractionStatus() {
        Task {
            do {
                let interactionResponse = try await APIClient.fetchInteraction(user1Id: Control.getUserId(), user2Id: userId)
                //print(interactionResponse)
                
                if (!interactionResponse.success) {
                    return
                }
                if (interactionResponse.interaction == nil) {
                    interactStatus = "Interact"
                } else {
                    interactStatus = "Interacting"
                }
                
                let interactionRequestResponse = try await APIClient.fetchInteractionRequest(senderId: Control.getUserId(), recipientId: userId)
                //print(interactionRequestResponse)
                if (!interactionRequestResponse.success) {
                    return
                }
                if (interactStatus != "Interacting" && interactionRequestResponse.notification != nil) {
                    interactStatus = "Interaction Request Sent"
                }
            } catch {
                print(error)
            }
        }
    }
    
    func handleSendingInteraction() {
        Task {
            do {
                if (interactStatus == "Interact") {
                    //send interaction request
                    let createInteractionResponse = try await APIClient.createInteractionRequest(senderId: Control.getUserId(), recipientId: userId)
                    if (!createInteractionResponse.success) {
                        return
                    }
                    
                    //send to socket
                    let body = [
                        "senderId": Control.getUserId(),
                        "recipientId": userId
                    ]
                    socket.emit("sendNotification", body)
                    
                } else if (interactStatus == "Interacting") {
                    //stop interaction
                    
                } else if (interactStatus == "Interaction Request Sent") {
                    //cancel interaction request
                    
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ProfilePage(
        path: .constant(["profile-67e1f1ebe8357f816722b319"])
    )
    .ignoresSafeArea(.keyboard)
}
