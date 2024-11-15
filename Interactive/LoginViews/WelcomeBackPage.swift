//
//  WelcomeBackPage.swift
//  Interactive
//
//  Created by Justin Zou on 11/8/24.
//

import SwiftUI

struct WelcomeBackPage: View {
    @Binding var path: [String]
    @State private var email: String = ""
    @State private var password: String = ""
    var global = GlobalVariables()
    var body: some View {
        ZStack {
            Color.white.opacity(0.001)
                .ignoresSafeArea()
                .background(
                    Image("Background1")
                        .resizable()
                        .ignoresSafeArea()
                )
            VStack {
                Button(action: {
                    path.removeLast()
                }) {
                    Image("chevron-back")
                        .resizable()
                        .frame(width:30,height:30)
                }
                .frame(maxWidth:.infinity,alignment:.leading)
                Text("Welcome Back")
                    .font(.system(size:37,weight:.semibold))
                    .foregroundStyle(Color.white)
                VStack{
                    Circle()
                        .fill(Helper.hexColor(hexCode: "#FFDD1A"))
                        .frame(width:16,height:16)
                        .padding([.bottom],-4)
                    Rectangle()
                        .fill(Helper.hexColor(hexCode: "#FFDD1A"))
                        .frame(width:16,height:52)
                        .clipShape(RoundedRectangle(cornerRadius:12.11))
                        .padding([.bottom],10)
                }
                    .background(
                        Circle()
                            .fill(Helper.hexColor(hexCode:"#333333"))
                            .frame(width:113,height:113)
                    )
                    .padding([.vertical],20)
                TextField("", text: $email, prompt: Text(verbatim: "example@gmail.com")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundColor(Helper.hexColor(hexCode: "#B3B3B3")))
                    .foregroundStyle(.white)
                    .padding(16)
                    .frame(width:361,height:43)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .foregroundColor(Helper.hexColor(hexCode: "#B3B3B3"))
                    .padding([.top],20)
                    .padding([.bottom],10)
                TextField("", text: $password, prompt: Text(verbatim: "password")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundColor(Helper.hexColor(hexCode: "#B3B3B3")))
                    .foregroundStyle(.white)
                    .padding(16)
                    .frame(width:361,height:43)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .foregroundColor(Helper.hexColor(hexCode: "#B3B3B3"))
                    .padding([.top],15)
                    .padding([.bottom],5)
                Group {
                    Text("Forgot Password? ")
                        .font(.system(size:16,weight:.semibold))
                        .foregroundStyle(Helper.hexColor(hexCode: "#CCCCCC")) 
                    +
                    Text("Reset")
                        .font(.system(size:16,weight:.semibold))
                        .foregroundStyle(Helper.hexColor(hexCode: "#FFE54D"))
                        .underline()
                }
                .frame(maxWidth:361,alignment:.leading)
                
                Button(action: {
                    global.test += 1
                    print(global.test)
                }) {
                    Text("Submit")
                        .font(.system(size:17,weight:.semibold))
                        .foregroundStyle(Helper.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:361,height:40)
                .background(Helper.hexColor(hexCode: "#FFDD1A"))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
                .padding([.vertical],20)
                Spacer()
                Text("New to Interactive?")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Helper.hexColor(hexCode: "#FFE54D"))
                    .frame(maxWidth:361,alignment:.leading)
                Button(action: {
                    path.removeLast()
                    path.append("About You")
                }) {
                    Text("Create new account")
                        .font(.system(size:17,weight:.semibold))
                        .foregroundStyle(Helper.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:361,height:40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
            }
            .frame(maxWidth:361)
        }
    }
}

#Preview {
    WelcomeBackPage(path:.constant(["Login","Welcome Back"]))
}
