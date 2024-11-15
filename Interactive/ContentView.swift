//
//  ContentView.swift
//  Interactive
//
//  Created by Justin Zou on 11/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    //@State private var path : [String] = ["Login"]
    var body: some View {
        NavigationStack(path:$viewModel.path) {
            //placeholder view required to put navigationDestination
            Text("")
            .navigationDestination(for: String.self) {
                page in
                if (page == "Login") {
                    LoginPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                        .ignoresSafeArea()
                } else if (page == "Welcome Back") {
                    WelcomeBackPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
 
                } else if (page == "About You") {
                    AboutYouPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Add Email") {
                    AddEmailPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Share Location") {
                    ShareLocationPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                }
                else {
                    Text("You selected \(page)")
                }
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
