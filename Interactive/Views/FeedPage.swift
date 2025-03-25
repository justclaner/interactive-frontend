//
//  FeedPage.swift
//  Interactive
//
//  Created by Justin Zou on 3/18/25.
//

import SwiftUI

struct FeedPage: View {
    @Binding var path: [String]
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
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    FeedPage(path: .constant(["Feed Page"]))
        .ignoresSafeArea(.keyboard)
}
