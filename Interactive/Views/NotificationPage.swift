//
//  NotificationPage.swift
//  Interactive
//
//  Created by Justin Zou on 4/18/25.
//

import SwiftUI
import SocketIO

let manager = SocketManager(socketURL: URL(string: "http://localhost:3002")!, config: [.log(true), .compress])
let socket: SocketIOClient = manager.defaultSocket

struct NotificationPage: View {
    @Binding var path: [String]
    @State var notifications: [String] = []
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.001)
                .ignoresSafeArea()
                .background(
                    Image("Background1")
                        .resizable()
                        .ignoresSafeArea()
                )
            VStack {
                Text("Notifications")
                    .font(.system(size:Control.largeFontSize, weight: .bold))
                    .foregroundStyle(.white)
                ScrollView {
                    LazyVStack {
                        ForEach(0..<notifications.count, id: \.self) { i in
                            Notification(notificationId: .constant(notifications[i]),
                                         socket: .constant(socket))
                        }
                    }
                    .frame(width: Control.maxWidth)
                }
                .frame(width: Control.maxWidth, height: Control.maxHeight * 0.71)
                Spacer();
            }
            .onTapGesture {
                let testData = [
                    "senderId": 5,
                    "recipientId": 10
                ]
                print("sending data")
                //socket.emit("sendNotification", testData)
            }
            NavigationBar(path: $path)
        }
        .onAppear {
            getNotifications()
            socket.connect()
//            socket.on(clientEvent: .connect) {data, ack in
//                print("socket connected")
//            }
            socket.on("receiveNotification") {data, ack in
                print(data[0])
                getNotifications()
            }
            
            socket.on("acceptedInteraction") {data, ack in
                Task {
                    do {
                        guard let dict = data[0] as? [String: Any] else {
                                        print("Could not cast data[0] to dictionary")
                                        return
                                    }
                        let jsonData = try JSONSerialization.data(withJSONObject: dict)
                        let body = try JSONDecoder().decode(SocketClient.connectionBody.self, from: jsonData)
                        if (body.senderId as String == Control.getUserId()) {
                            getNotifications()
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    func getNotifications() {
        Task {
            do {
                let notificationsResponse = try await APIClient.fetchNotificationFromRecipient(recipientId: UserDefaults.standard.string(forKey: "userId")!)
               // print(notificationsResponse)
                if (notificationsResponse.success) {
                    notifications = []
                    notificationsResponse.notifications!.forEach { notification in
                        notifications.append(notification._id);
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    NotificationPage(path: .constant(["Notifications"]))
}
