//
//  Notification.swift
//  Interactive
//
//  Created by Justin Zou on 4/6/25.
//

import SwiftUI
import SocketIO

struct Notification: View {
    //@Binding var path: [String]
    @Binding var notificationId: String
    @Binding var socket: SocketIOClient
    
    @State var profileImageUrl: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg"
    @State var username: String = "username"
    @State var userId: String = "userId"
    @State var message: String = "interacted with you"
    @State var isInteracting: Bool = false
    @State var action: String = "InteractRequest"
//    init(path: Binding<[String]>) {
//        self._path = path
//        self._notificationId = State(initialValue: (path.wrappedValue.last != nil && path.wrappedValue.last?.count ?? 0 > 13)
//        ? String(path.wrappedValue.last!.dropFirst(13))
//        : "")
//    }
    
    let imageSquareWidth = Control.maxWidth * 0.22
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url:URL(string:profileImageUrl)) {phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(width: imageSquareWidth, height: imageSquareWidth)
                        .clipShape(
                            RoundedRectangle(cornerRadius: Control.tinyFontSize)
                        )
                } else {
                    RoundedRectangle(cornerRadius: Control.mediumFontSize)
                        .fill(Color.gray)
                        .frame(width: imageSquareWidth, height: imageSquareWidth)
                }
            }
            .padding([.leading])
            VStack {
                Spacer()
                HStack {
                    Text(username)
                        .font(.system(size:Control.tinyFontSize, weight:.bold))
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack {
                    Text(message)
                        .font(.system(size:Control.tinyFontSize))
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: action == "Interact" ? Control.maxWidth * 0.35 : Control.maxWidth * 0.5, maxHeight: imageSquareWidth, alignment: .leading)
            .padding([.leading], 0.5*Control.tinyFontSize)

            Spacer()
            if (action == "Interact") {
                Button(action: {
                    isInteracting.toggle()
                }) {
                    Text(isInteracting ? "Interacting" : "Interact")
                        .font(.system(size: Control.tinyFontSize, weight: .semibold))
                        .foregroundStyle(Control.hexColor(hexCode: isInteracting ? "#000000" : "#FFDD1A"))
                }
                .frame(width:Control.maxWidth*0.35,height:Control.largeFontSize)
                .background(Control.hexColor(hexCode: isInteracting ? "#FFDD1A" :"#333333"))
                .clipShape(RoundedRectangle(cornerRadius: 0.5 * Control.tinyFontSize))
                .padding([.trailing])
            } else if (action == "InteractRequest") {
                HStack {
                    Image("reject_interact")
                        .resizable()
                        .scaledToFill()
                        .frame(width: Control.maxWidth * 0.1, height: Control.maxWidth * 0.1)
                        .onTapGesture {
                            Task {
                                deleteAndUpdate()
                            }
                            print("reject interaction")
                        }
                    Image("accept_interact")
                        .resizable()
                        .scaledToFill()
                        .frame(width: Control.maxWidth * 0.1, height: Control.maxWidth * 0.1)
                        .onTapGesture {
                            addInteraction()
                            deleteAndUpdate()
                        }
                }
                .padding([.trailing], Control.tinyFontSize)
            }
        }
        .padding([.vertical])
        .frame(width: Control.maxWidth)
        .background(
            RoundedRectangle(cornerRadius: Control.mediumFontSize)
                .stroke(Control.hexColor(hexCode: "#9A9A9A"))
                .fill(Control.hexColor(hexCode: "#9A9A9A"))
        )
        .onTapGesture {
            //print(notificationId)
        }
        .onAppear {
           // print(notificationId);
            getNotification()
        }
    }
    
    func getNotification() {
        Task {
            do {
                //fetch notification
                let notificationResponse = try await APIClient.fetchNotification(notificationId: notificationId)
               // print(notificationResponse)
                if (notificationResponse.success) {
                    //handle action to update message
                    if (notificationResponse.notification != nil) {
                        //action = notificationResponse.notification!.action
                        switch (notificationResponse.notification!.action) {
                            case "Interact":
                                message = "Interacted with you"
                            case "InteractRequest":
                                message = "wants to Interact with you"
                            default:
                                message = "visited your profile"
                        }
                    }
                    
                    
                    if (notificationResponse.notification != nil) {
                        let userResponse = try await APIClient.fetchUser(userId: notificationResponse.notification!.sender_id)
                        //print(userResponse)
                        if (userResponse.success && userResponse.user != nil) {
                            username = userResponse.user!.username
                            userId = userResponse.user!._id
                            //get user image
                            let imageResponse = try await APIClient.fetchUserImages(userId: userId)
                            //print(imageResponse)
                            if (imageResponse.success) {
                                if (imageResponse.images.image1 != nil) {
                                    profileImageUrl = imageResponse.images.image1!
                                }
                            }
                        }
                    }
                }
                

            } catch {
                print(error)
            }
        }

    }
    
    func addInteraction() {
        Task {
            do {
                let _ = try await APIClient.createInteraction(userId1: Control.getUserId(), userId2: userId)
            } catch {
                print(error)
            }
        }
    }
    
    func deleteAndUpdate() {
        Task {
            do {
                let _ = try await APIClient.deleteNotification(notificationId: notificationId)
            
                
                let data = [
                    "senderId": Control.getUserId(),
                    "recipientId": userId
                    
                ]
                socket.emit("acceptInteraction", data)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    Notification(notificationId: .constant("67f5da39528a58f2a31ebb16"), socket: .constant(
        SocketManager(socketURL: URL(string: "http://localhost:3002")!, config: [.log(true), .compress])
            .defaultSocket
        )
    )
}
