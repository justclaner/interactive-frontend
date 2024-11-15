//
//  ContentView.swift
//  Interactive
//
//  Created by Justin Zou on 11/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var path : [String] = ["Login"]
    var body: some View {
        NavigationStack(path:$path) {
            //placeholder view required to put navigationDestination
            Text("Root View")
            .navigationDestination(for: String.self) {
                page in
                if (page == "Login") {
                    LoginPage(path:$path).navigationBarBackButtonHidden(true)
                        .ignoresSafeArea()
                } else if (page == "Welcome Back") {
                    WelcomeBackPage(path:$path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "About You") {
                    AboutYouPage(path:$path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Add Email") {
                    AddEmailPage(path:$path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Share Location") {
                    ShareLocationPage(path:$path)
                        .navigationBarBackButtonHidden(true)
                }
                else {
                    Text("You selected \(page)")
                }
            }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
