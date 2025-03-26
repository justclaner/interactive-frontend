//
//  HomePage.swift
//  Interactive
//
//  Created by Justin Zou on 2/11/25.
//

import SwiftUI

struct HomePage: View {
    
    @Binding var path: [String]
    @State private var scrollOffset = 0.0
    @State private var visibleCardCount: Int = 6
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
                    print(scrollOffset)
                }
            VStack(spacing: 0) {
                Text("Home")
                    .font(.system(size:Control.largeFontSize, weight: .bold))
                    .foregroundStyle(.white)
                ScrollView(showsIndicators: false) {
                    HStack(spacing: Control.smallFontSize) {
                        VStack(spacing: Control.smallFontSize) {
                            ForEach(0..<min(userIds.count/2, visibleCardCount/2), id: \.self) { index in
                                ProfileCard(userId: .constant(userIds[2*index]))
                            }
                            if (userIds.count % 2 == 1) {
                                ProfileCard(userId: .constant(userIds[userIds.count - 1]))
                            }
                            Spacer()
                        }
                        VStack(spacing: Control.smallFontSize) {
                            ForEach(0..<min(userIds.count/2, visibleCardCount/2), id: \.self) { index in
                                ProfileCard(userId: .constant(userIds[2*index + 1]))
                            }
                            Spacer()
                        }
                    }
//                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Control.tinyFontSize) {
//                        ForEach(0..<min(visibleCardCount, userLinks.count), id: \.self) {index in
//                            ProfileCard(userId: .constant(userLinks[index]))
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
                    
                    PlusIcon()
                        .padding([.top], Control.largeFontSize)
                        .padding([.bottom], 0.75 * Control.navigationBarHeight)
                        .onTapGesture {
                            visibleCardCount += 6
                        }
                }
                .coordinateSpace(name: "scroll")
                .padding()
//                .onScrollPhaseChange { oldPhase, newPhase in
//                            print(newPhase)
//                        }
                Spacer()
                
            }
            NavigationBar()
        }
        .onAppear {
            updateUserIds()
        }
    }
    
    private func updateUserIds() -> Void {
        Task {
            do {
                let nearbyUsers = try await APIClient.fetchNearbyUsers()
                if (nearbyUsers.success) {
                    userIds = []
                    uniqueIds = []
                    let locations = nearbyUsers.locations!
                    locations.forEach { location in
                        if (!uniqueIds.contains(location.user_id)) {
                            uniqueIds.insert(location.user_id)
                            userIds.append(location.user_id)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    HomePage(path: .constant(["Home Page"]))
        .ignoresSafeArea(.keyboard)
}
