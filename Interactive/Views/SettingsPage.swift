//
//  Settings.swift
//  Interactive
//
//  Created by Justin Zou on 2/24/25.
//

import SwiftUI

struct SettingsPage: View {
    @Binding var path: [String]
    
    @State var phoneNumber: String = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
    @FocusState var phoneNumberFocus: Bool
    
    @State var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @FocusState var emailFocus: Bool
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
                    phoneNumberFocus = false
                    print(Control.mediumFontSize)
                }
            BackButton(path: $path)
            VStack {
                Text("Settings")
                    .font(.system(size:Control.mediumFontSize, weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(width: Control.maxWidth, alignment: .center)
                    .padding([.bottom], Control.largeFontSize)
                Text("Account Settings")
                    .font(.system(size:Control.smallFontSize, weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(width: Control.maxWidth, alignment: .leading)
                VStack {
                    TextField("", text: $phoneNumber, prompt: Text("Phone Number")
                        .font(.system(size:Control.tinyFontSize,weight:.semibold))
                        .foregroundColor(Control.hexColor(hexCode: "#CCCCCC").opacity(0.6))
                    )
                        .font(.system(size:Control.tinyFontSize,weight:.semibold))
                        .foregroundColor(Control.hexColor(hexCode: "#CCCCCC"))
                        .padding(Control.tinyFontSize)
                        .background(Control.hexColor(hexCode: "#4D4D4D"))
                        .frame(width:Control.maxWidth,height: Control.mediumHeight)
                        .clipShape(RoundedRectangle(cornerRadius:8))
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Control.hexColor(hexCode: "#4D4D4D"), lineWidth: 1)
                        )
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .focused($phoneNumberFocus)
                        .padding([.bottom], Control.getScreenSize().height * 0.005)
                    
                    TextField("", text: $email, prompt: Text("Email")
                        .font(.system(size:Control.tinyFontSize,weight:.semibold))
                        .foregroundColor(Control.hexColor(hexCode: "#CCCCCC").opacity(0.6))
                    )
                        .font(.system(size:Control.tinyFontSize,weight:.semibold))
                        .foregroundColor(Control.hexColor(hexCode: "#CCCCCC"))
                        .padding(Control.tinyFontSize)
                        .background(Control.hexColor(hexCode: "#4D4D4D"))
                        .frame(width:Control.maxWidth,height: Control.mediumHeight)
                        .clipShape(RoundedRectangle(cornerRadius:8))
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Control.hexColor(hexCode: "#4D4D4D"), lineWidth: 1)
                        )
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .focused($emailFocus)
                        .padding([.bottom], Control.getScreenSize().height * 0.005)
                }
                Text("Privacy and Safety")
                    .font(.system(size:Control.smallFontSize, weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(width: Control.maxWidth, alignment: .leading)
                    .padding([.top], Control.getScreenSize().height * 0.02)
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsPage(path: .constant(["Settings"]))
}
