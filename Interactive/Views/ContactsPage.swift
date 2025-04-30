//
//  ContactsPage.swift
//  Interactive
//
//  Created by Justin Zou on 4/28/25.
//

import SwiftUI

struct ContactsPage: View {
    @Binding var path: [String]
    @State private var visibleCardCount: Int = 6
    @State private var scrollOffset = 0.0
    @State private var userIds: [String] = []
    @State private var uniqueIds: Set<String> = []
    @GestureState private var dragOffset: CGSize = .zero
    @State private var isLoading: Bool = false
    
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
                   // print(scrollOffset)
                }
            VStack(spacing: 0) {
                Text("Contacts")
                    .font(.system(size:Control.largeFontSize, weight: .bold))
                    .foregroundStyle(.white)
                ScrollView(showsIndicators: false) {
                    HStack(spacing: Control.smallFontSize) {
                        VStack(spacing: Control.smallFontSize) {
                            ForEach(0..<min(visibleCardCount / 2, userIds.count / 2), id: \.self) { index in
                                ProfileCard(
                                    userId: .constant(userIds[2*index])
                                )
                                    .highPriorityGesture(
                                        TapGesture().onEnded {
                                            path.append("profile-\(userIds[2*index])")
                                        }
                                    )
                            }
                            if (userIds.count % 2 == 1) {
                                ProfileCard(userId: .constant(userIds[userIds.count - 1]))
                                    .highPriorityGesture(
                                        TapGesture().onEnded {
                                            path.append("profile-\(userIds[userIds.count - 1])")
                                        }
                                    )
                            }
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        VStack(spacing: Control.smallFontSize) {
                            ForEach(0..<min(visibleCardCount / 2, userIds.count / 2), id: \.self) { index in
                                ProfileCard(userId: .constant(userIds[2*index + 1]))
                                    .highPriorityGesture(
                                        TapGesture().onEnded {
                                            path.append("profile-\(userIds[2*index + 1])")
                                        }
                                    )
                            }
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .contentShape(Rectangle())
                    
//                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Control.tinyFontSize) {
//                        ForEach(0..<userIds.count, id: \.self) {index in
//                            ProfileCard(userId: .constant(userIds[index]))
//                                .highPriorityGesture(
//                                    TapGesture().onEnded {
//                                        path.append("profile-\(userIds[userIds.count - 1])")
//                                    }
//                                )
//                        }
//                    }
                    .background(GeometryReader { proxy -> Color in
                        DispatchQueue.main.async {
                            scrollOffset = -proxy.frame(in: .named("scroll")).origin.y
                            if (!isLoading && scrollOffset < -100) {
                                isLoading = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    print("updating user ids")
                                    updateUserIds()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    isLoading = false
                                }
                            }
                        //print(scrollOffset)
                        }
                        return Color.clear
                    })
                }
                .coordinateSpace(name: "scroll")
                .padding()
//                .onScrollPhaseChange { oldPhase, newPhase in
//                            print(newPhase)
//                        }
                
                PlusIcon()
                    .padding([.top], Control.largeFontSize)
                    .padding([.bottom], 0.75 * Control.navigationBarHeight)
                    .onTapGesture {
                        visibleCardCount += 6
                    }
                Spacer()
                
            }
            NavigationBar(path: $path)
        }
        .onAppear {
            print("loaded contacts page")
            updateUserIds()
        }
    }
    
    private func updateUserIds() -> Void {
        Task {
            do {
                let contactsResponse = try await APIClient.fetchContacts(userId: Control.getUserId())
                if (contactsResponse.success) {
                    userIds = []
                    uniqueIds = []
                    let contacts = contactsResponse.interactions!
                    contacts.forEach { interaction in
                        if (!uniqueIds.contains(interaction.user1_id) && interaction.user1_id != Control.getUserId()) {
                            uniqueIds.insert(interaction.user1_id)
                            userIds.append(interaction.user1_id)
                        } else if (!uniqueIds.contains(interaction.user2_id) && interaction.user2_id != Control.getUserId()) {
                            uniqueIds.insert(interaction.user2_id)
                            userIds.append(interaction.user2_id)
                        }
                    }
                }
                
//                let nearbyUsers = try await APIClient.fetchNearbyUsers()
//                if (nearbyUsers.success) {
//                    userIds = []
//                    uniqueIds = []
//                    let locations = nearbyUsers.locations!
//                    locations.forEach { location in
//                        if (!uniqueIds.contains(location.user_id) && location.user_id != UserDefaults.standard.string(forKey: "userId")!) {
//                            uniqueIds.insert(location.user_id)
//                            userIds.append(location.user_id)
//                        }
//                    }
//                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContactsPage(path: .constant(["Contacts Page"]))
        .ignoresSafeArea(.keyboard)
}
