//
//  HomePage.swift
//  Interactive
//
//  Created by Justin Zou on 2/11/25.
//

import SwiftUI

struct HomePage: View {
    
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
                    print("hello")
                }
        }
    }
}

#Preview {
    HomePage(path: .constant(["Home Page"]))
        .ignoresSafeArea(.keyboard)
}
