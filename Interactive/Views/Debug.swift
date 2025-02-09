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
                    testCall()
                }
        }
    }
    
    func testCall() {
        
        //data.cleanCompleteStorage()
//        print(data.getCounter())
//        UserDefaults.standard.set("true", forKey:"inTutorial")
        Task {
            do {
                let auth = try await APIClient.checkUsernameExist(username: "test1")
                print(auth)
            } catch {
                print(error)
            }
            
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

    //    Task {
    //        do {
    //            let users = try await APIClient.fetchAllUsers()
    //            let usernames = users.users.map {
    //                $0.username
    //            }
    //            print(usernames)
    //        } catch {
    //            print(error)
    //        }
    //    }
    }

}

#Preview {
    Debug()
}

