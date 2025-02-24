//
//  WelcomeBackPage.swift
//  Interactive
//
//  Created by Justin Zou on 11/8/24.
//

import SwiftUI

struct WelcomeBackPage: View {
    @Binding var path: [String]
    @EnvironmentObject var locationManager: LocationManager
    
    @State var requestedLocation: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState var emailFocus: Bool
    @FocusState var passwordFocus: Bool
    
    
//    @EnvironmentObject var locationManager: LocationManager
    
    @State private var authError: Bool = false
    @State private var errorMessage: String = "Email or password is incorrect or the user does not exist!"

    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var data = UserData()
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
                    emailFocus = false
                    passwordFocus = false
                    authError = false
                    print("test")
                    print(locationManager.authorizationStatus ?? "")
                }
            BackButton(path:$path)
                .padding([.top],8)
            VStack {
                Text("Welcome Back")
                    .font(.system(size:Control.largeFontSize,weight:.semibold))
                    .foregroundStyle(Color.white)
                LargeLogo()
                    .padding([.vertical],20)
                TextField("", text: $email, prompt: Text(verbatim: "example@gmail.com")
                    .font(.system(size:Control.smallFontSize,weight:.semibold))
                    .foregroundColor(Control.hexColor(hexCode: "#B3B3B3")))
                    .foregroundStyle(.white)
                    .padding(Control.smallFontSize)
                    .frame(width:Control.maxWidth,height:Control.maxHeight)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundColor(Control.hexColor(hexCode: "#B3B3B3"))
                    .padding([.top],20)
                    .padding([.bottom],10)
                    .focused($emailFocus)
                SecureField("", text: $password, prompt: Text(verbatim: "password")
                    .font(.system(size:Control.smallFontSize,weight:.semibold))
                    .foregroundColor(Control.hexColor(hexCode: "#B3B3B3")))
                    .foregroundStyle(.white)
                    .padding(Control.smallFontSize)
                    .frame(width:Control.maxWidth,height: Control.maxHeight)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundColor(Control.hexColor(hexCode: "#B3B3B3"))
                    .padding([.top],15)
                    .padding([.bottom],5)
                    .focused($passwordFocus)
                Group {
                    Text("Forgot Password? ")
                        .font(.system(size:Control.smallFontSize,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                    +
                    Text("Reset")
                        .font(.system(size:Control.smallFontSize,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#FFE54D"))
                        .underline()
                }
                .frame(maxWidth:Control.maxWidth,alignment:.leading)
                Text(errorMessage)
                    .font(.system(size:Control.smallFontSize, weight:.semibold))
                    .foregroundStyle(Color.red)
                    .opacity(authError ? 1 : 0.01)
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                    .offset(x:0,y:3)
                
                Button(action: {
                    Task {
                        do {
                            let response = try await APIClient.authenticateUser(email: email, password: password)
                            if (!response.success) {
                                print("authentication failed")
                                authError = true
                            } else {
                                if (response.user != nil) {
                                    if (!requestedLocation) {
                                        Task {
                                            locationManager.requestLocation()
                                            // disable if buggy
                                            data.cleanCompleteStorage()
                                            data.loadFromUserJSON(user: response.user!, password: password)
                                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                requestedLocation = true
                                            }
                                        }
                                    } else {
                                        path = ["Your Profile"]
                                    }
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                }) {
                    Text(requestedLocation ? "Continue" : "Log In")
                        .font(.system(size:Control.smallFontSize,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:Control.maxWidth,height: Control.mediumHeight)
                .background(Control.hexColor(hexCode: "#FFDD1A"))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
                .padding([.top],5)
                Spacer()
                Text("New to Interactive?")
                    .font(.system(size:Control.smallFontSize,weight:.semibold))
                    .foregroundStyle(Control.hexColor(hexCode: "#FFE54D"))
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                Button(action: {
                    path.removeLast()
                    path.append("About You")
                }) {
                    Text("Create new account")
                        .font(.system(size:Control.smallFontSize,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:Control.maxWidth,height: Control.mediumHeight)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
            }
            .frame(maxWidth:Control.maxWidth)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    WelcomeBackPage(path:.constant(["Login","Welcome Back"]))
}
