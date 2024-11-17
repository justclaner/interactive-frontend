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
                    //add
                }
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                LargeLogo()
                    .padding([.top],30)
                Text("Add your email")
                    .font(.system(size:31,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .padding([.top],40)
                    .frame(maxWidth:361,alignment:.leading)
                Text("Connect your email and choose a password to access in the future")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Helper.hexColor(hexCode: "#CCCCCC"))
                    .padding([.vertical],20)
                    .frame(maxWidth:361,alignment:.leading)
                Text("Email")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                TextField("", text:$email, prompt: Text(verbatim: "example@test.com")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Helper.hexColor(hexCode: "#B3B3B3")))
                    .padding(16)
                    .frame(width:361,height:43)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .foregroundStyle(Helper.hexColor(hexCode: "#B3B3B3"))
                Text("Password")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                    .padding([.top],30)
                TextField("", text:$password, prompt: Text(verbatim: "Choose a strong password")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Helper.hexColor(hexCode: "#B3B3B3")))
                    .padding(16)
                    .frame(width:361,height:43)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .foregroundStyle(Helper.hexColor(hexCode: "#B3B3B3"))
                Spacer()
                Button(action: {
                    path.append("Share Location")
                }) {
                    Text("Go to Profile")
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
            }
            .frame(maxWidth:361)
        }
    }
}

#Preview {
    AddEmailPage(path:.constant(["Login","About You","Add Email"]))
}
