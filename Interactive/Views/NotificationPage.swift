//
//  NotificationPage.swift
//  Interactive
//
//  Created by Justin Zou on 4/18/25.
//

import SwiftUI
import SocketIO



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
                .onTapGesture {
                    
                }
            VStack {
                Text("Notifications")
                    .font(.system(size:Control.largeFontSize, weight: .bold))
                    .foregroundStyle(.white)
                ScrollView {
                    LazyVStack {
                        ForEach(0..<notifications.count, id: \.self) { i in
                            Notification(notificationId: .constant(notifications[i]))
                        }
                    }
                    .frame(width: Control.maxWidth)
                }
                .frame(width: Control.maxWidth, height: Control.maxHeight * 0.71)
                Spacer();
            }
            
            NavigationBar(path: $path)
        }
        .onAppear {
            getNotifications()
        }
    }
    
    func getNotifications() {
        Task {
            do {
                let notificationsResponse = try await APIClient.fetchNotificationFromRecipient(recipientId: UserDefaults.standard.string(forKey: "userId")!)
                print(notificationsResponse)
                if (notificationsResponse.success) {
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
