//
//  AllDonePage.swift
//  Interactive
//
//  Created by Justin Zou on 11/17/24.
//

import SwiftUI

struct AllDonePage: View {
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
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                LargeLogo()
                    .padding([.top],30)
                    .padding([.bottom],20)
                Text("You have everything you need!")
                    .font(.system(size:31,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding([.vertical],10)
                Group {
                    Text("You have entered in the basic information.")
                            .font(.system(size:16,weight:.regular))
                            .bold()
                            .foregroundStyle(Color.white)
                    +
                    Text(" To maximize your visibility and attract more contacts:")
                        .font(.system(size:16,weight:.regular))
                        .foregroundStyle(Control.hexColor(hexCode: "#E6E6E6"))
                }
                .padding([.vertical],10)
                .frame(maxWidth:361,alignment: .leading)
                HStack {
                    Text("Complete your profile")
                        .font(.system(size:16,weight:.bold))
                        .foregroundStyle(Control.hexColor(hexCode: "#FFE54D"))
                        .onTapGesture() {
                            let data = UserDefaults.standard;
                            let userData: Encodable = [
                                "username": data.string(forKey:"username")!,
                                "email": data.string(forKey:"email")!,
                                "password": data.string(forKey:"password")!,
                                "birthDay": String(data.integer(forKey:"birthDay")),
                                "birthMonth": data.string(forKey:"birthMonth")!,
                                "birthYear": String(data.integer(forKey:"birthYear"))
                            ]
                            Task {
                                do {
                                    let createUserResult = try await APIClient.createUser(body: userData)
                                    let findUser = try await APIClient.getUserFromUsername(username: data.string(forKey:"username")!)
                                    print(findUser)
                                    print(String(findUser.user?._id ?? ""))
                                    UserDefaults.standard.set(String(findUser.user?._id ?? ""), forKey:"userId")
                                    
                                    print(createUserResult)
                                    path = ["Your Profile"]
                                } catch {
                                    print(error)
                                }
                            }
                            
                        }
                        .padding([.trailing],10)
                    Image(systemName:"chevron.right")
                        .font(.system(size:12))
                        .foregroundStyle(Control.hexColor(hexCode:"#CCCCCC"))
                        .background(
                        Circle()
                            .fill(Control.hexColor(hexCode:"#333333"))
                            .frame(width:20,height:20)
                        )
                        .onTapGesture() {
                            //change path
                        }
                    Spacer()
                }
                .frame(maxWidth:361)
                Spacer()
            }
            .frame(maxWidth:361)
        }
    }
}

#Preview {
    AllDonePage(path:.constant(["Login","About You","Add Email", "Share Location", "All Done"]))
}
