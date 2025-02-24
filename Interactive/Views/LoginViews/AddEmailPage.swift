//
//  AddEmailPage.swift
//  Interactive
//
//  Created by Justin Zou on 11/14/24.
//

import SwiftUI

struct AddEmailPage: View {
    
    @Binding var path: [String]
    @State var email = ""
    @State var password = ""
    @FocusState var emailFocus: Bool
    @FocusState var passwordFocus: Bool
    
    @State var emailWarning: Bool = false
    @State var passwordWarning: Bool = false
    @State var emailWarningText: String = "temporary text"
    @State var passwordWarningText: String = "temporary text"
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
                    emailWarning = false
                    passwordWarning = false
                }
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                LargeLogo()
                    .padding([.top],30)
                Text("Add your email")
                    .font(.system(size:Control.mediumFontSize,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .padding([.top],Control.mediumHeight)
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                Text("Connect your email and choose a password to access in the future")
                    .font(.system(size:Control.smallFontSize,weight:.regular))
                    .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                    .padding([.vertical],20)
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                Text("Email")
                    .font(.system(size:Control.smallFontSize,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                TextField("", text:$email, prompt: Text(verbatim: "example@test.com")
                    .font(.system(size:Control.smallFontSize,weight:.semibold))
                    .foregroundStyle(Control.hexColor(hexCode: "#B3B3B3")))
                    .padding(Control.smallFontSize)
                    .frame(width:Control.maxWidth,height:Control.maxHeight)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundStyle(Control.hexColor(hexCode: "#B3B3B3"))
                    .focused($emailFocus)
                Text(emailWarningText)
                    .font(.system(size:Control.smallFontSize, weight:.semibold))
                    .foregroundStyle(Color.red)
                    .opacity(emailWarning ? 1 : 0.01)
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                
                Text("Password")
                    .font(.system(size:Control.smallFontSize,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                    .padding([.top],30)
                SecureField("", text:$password, prompt: Text(verbatim: "Choose a strong password")
                    .font(.system(size:Control.smallFontSize,weight:.semibold))
                    .foregroundStyle(Control.hexColor(hexCode: "#B3B3B3")))
                    .padding(Control.smallFontSize)
                    .frame(width:Control.maxWidth,height:Control.maxHeight)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundStyle(Control.hexColor(hexCode: "#B3B3B3"))
                    .focused($passwordFocus)
                Text(passwordWarningText)
                    .font(.system(size:Control.smallFontSize, weight:.semibold))
                    .foregroundStyle(Color.red)
                    .opacity(passwordWarning ? 1 : 0.01)
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                Spacer()
                Button(action: {
                    if (Control.isValidEmail(email: email) && Control.isValidPassword(password: password) && !email.isEmpty && !password.isEmpty) {
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(password, forKey: "password")
                        path.append("Share Location")
                        emailWarning = false
                        passwordWarning = false
                    }
                    
                    if (email.isEmpty) {
                        emailWarning = true
                        emailWarningText = "Email address is required."
                    } else if (!Control.isValidEmail(email: email)) {
                        emailWarning = true
                        emailWarningText = "This is not a valid email address."
                    }
                    if (password.isEmpty) {
                        passwordWarning = true
                        passwordWarningText = "Password is required."
                    } else if (!Control.isValidPassword(password: password)) {
                        passwordWarning = true
                        passwordWarningText = "Password must be at least 8 characters long, contain uppercase and lowercase letters, contain at least one digit, and contain at least one special character."
                    }
                    
                   
                }) {
                    Text("Continue")
                        .font(.system(size:Control.smallFontSize,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:Control.maxWidth,height:Control.mediumHeight)
                .background(Control.hexColor(hexCode: "#FFDD1A"))
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
    AddEmailPage(path:.constant(["Login","About You","Add Email"]))
}
