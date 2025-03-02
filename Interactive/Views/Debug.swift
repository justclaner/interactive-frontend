//
//  Debug.swift
//  Interactive
//
//  Created by Justin Zou on 1/31/25.
//

import SwiftUI

struct Debug: View {
    var data = UserData()
    var body: some View {
        ZStack {
            Color.blue.opacity(1)
                .ignoresSafeArea()
                .onTapGesture {
                    print("test")
                    testCall()
                }
            VStack {
                Button(action: {
                    data.cleanCompleteStorage()
                }) {
                    Text("Erase all User Defaults")
                        .font(.system(size:24))
                        .foregroundStyle(.black)
                }
                .padding([.leading, .trailing],15)
                .frame(height:40)
                .background(Control.hexColor(hexCode: "#FFDD1A"))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
                Image("settings_gear")
                    .resizable()
                    .frame(width:20,height:20)
//                AsyncImage(url: URL(string: "https://interactive-images.s3.us-east-1.amazonaws.com/c47d6f835850ce9f96a0635f09d66afe")) { result in
//                    result.image?
//                        .resizable()
//                        .scaledToFill()
//                }
//                .frame(width:200, height: 200)
                //.clipped()
                Spacer()
            }
            
        }
    }
    
    func testCall() {
        
        //data.incrementCounter()
      //  print(data.getCounter())
//       UserDefaults.standard.set("true", forKey:"inTutorial")
//        Task {
//            do {
//                let auth = try await APIClient.checkUsernameExist(username: "test1")
//                print(auth)
//                print(auth.success)
//            } catch {
//                print(error)
//            }
//            
//        }
//        Task {
//            do {
//                let imagesResponse = try await APIClient.getUserImages(userId: "67b292ad88a3f915d9776c78")
//                print(imagesResponse)
//            }
//        }
       // print(UserDefaults.standard.dictionaryRepresentation())
        print("fuck")
        Task {
            do {
//                let response = try await APIClient.createNetworkLink(platformName:"instagram", url:"https://www.instagram.com/")
                let response = try await APIClient.fetchUserNetworks()
                print(response)
            }
        }
        
//        Task {
//            do {
//                let res0 = try await APIClient.fetchAllUsers()
//                let res = try await APIClient.fetchUser(userId:"67a937faba8be5736f697b39")
//            } catch {
//                print(error)
//            }
//        }
        
        Task {
//            do {
//                let result = try await APIClient.getPresignedPostURL()
//                print(result)
//            } catch {
//                print(error)
//            }
        }
        Task {
//            do {
//                let auth = try await APIClient.authenticateUser(
//                    userId: "67a937faba8be5736f697b39",
//                    password: "1234"
//                )
//                print(auth)
//            } catch {
//                print(error)
//            }
        }

//        Task {
//            do {
//                let users = try await APIClient.fetchAllUsers()
//                let usernames = users.users.map {
//                    $0.username
//                }
//                print(usernames)
//            } catch {
//                print(error)
//            }
//        }
    }

}

#Preview {
    Debug()
}

