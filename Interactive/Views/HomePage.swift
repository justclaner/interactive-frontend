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
                        }
                        VStack(spacing: Control.smallFontSize) {
                            ForEach(0..<min(userIds.count/2, visibleCardCount/2), id: \.self) { index in
                                ProfileCard(userId: .constant(userIds[2*index + 1]))
                            }
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
                }.coordinateSpace(name: "scroll")
                    .padding()
                    
                Spacer()
                
            }
            NavigationBar()
        }
        .onAppear {
            Task {
                do {
                    let nearbyUsers = try await APIClient.fetchNearbyUsers()
                    if (nearbyUsers.success) {
                        let locations = nearbyUsers.locations!
                        locations.forEach { location in
                            userIds.append(location.user_id)
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
    HomePage(path: .constant(["Home Page"]))
        .ignoresSafeArea(.keyboard)
}
