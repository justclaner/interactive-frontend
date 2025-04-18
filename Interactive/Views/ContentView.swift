//
//  ContentView.swift
//  Interactive
//
//  Created by Justin Zou on 11/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        NavigationStack(path:$viewModel.path) {
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
                        .environmentObject(locationManager)
                } else if (page == "About You") {
                    AboutYouPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Add Email") {
                    AddEmailPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Share Location") {
                    ShareLocationPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(locationManager)
                } else if (page == "All Done") {
                    AllDonePage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Register Phone") {
                    RegisterPhonePage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Verify Phone") {
                    VerifyPhonePage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Your Profile") {
                    EditProfilePage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Add Network") {
                    AddNetworkPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Edit Network") {
                    UpdateNetworkPage(path:$viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Settings") {
                    SettingsPage(path: $viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Home Page") {
                    HomePage(path: $viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page.hasPrefix("profile-") && page.count == 32) {
                    ProfilePage(path: $viewModel.path)
                        .navigationBarBackButtonHidden(true)
                } else if (page == "Notifications") {
                    NotificationPage(path: $viewModel.path)
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
