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
                    print(ProfileSetup.tutorialStep)
                    print(UserDefaults.standard.bool(forKey: "inTutorial"))
                    print(ProfileSetup.tutorialStep < 1 && UserDefaults.standard.bool(forKey: "inTutorial"))
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
                AsyncImage(url: URL(string: "https://interactive-images.s3.us-east-1.amazonaws.com/c47d6f835850ce9f96a0635f09d66afe")) { result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
                .frame(width:200, height: 200)
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
//                print(auth.success)
//            } catch {
//                print(error)
//            }
//            
//        }
        
        Task {
//            do {
//                let result = try await APIClient.getPresignedPostURL()
//                print(result)
//            } catch {
//                print(error)
//            }
        }
    //    Task {
    //        do {
    //            let auth = try await APIClient.authenticateUser(
    //                userId: "67883e7bf72444443aab976c",
    //                password: "1234"
    //            )
    //            print(auth)
    //        } catch {
    //            print(error)
    //        }
    //    }

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

