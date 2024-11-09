//
//  LoginView.swift
//  Interactive
//
//  Created by Justin Zou on 11/3/24.
//

import SwiftUI

struct LoginPage: View {

    @Binding var path : [String]
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
                    Spacer()
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
                    .offset(x:0,y:-40)
                    VStack {
                        Button(action: {
                            path = ["Login","Welcome"]
                        }) {
                            Text("login")
                                .font(.system(size:17,weight:.bold))
                                .foregroundStyle(Color.black.opacity(0.75))
                                .padding()
                                .frame(maxWidth:.infinity,maxHeight:.infinity)
                        }
                        
                        .frame(width:361,height:40)
                        .background(Helper.hexColor(hexCode: "#FFDD1A"))
                        .clipShape(RoundedRectangle(cornerRadius:20))
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.6), lineWidth: 1)
                        )
                        .padding([.vertical],10)
                     
                        Button(action: {
                            //change path
                        }) {
                            Text("create an account")
                                .font(.system(size:17,weight:.bold))
                                .foregroundStyle(Color.black.opacity(0.75))
                                .padding(10)
                        }
                        .frame(width:361,height:40)
                        .background(Helper.hexColor(hexCode: "#FFDD1A"))
                        .clipShape(RoundedRectangle(cornerRadius:20))
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.6), lineWidth: 1)
                        )
                    }
                    Spacer()
                }
                .offset(x:0,y:-60)
            }
        
    }
}

#Preview {
    LoginPage(path:.constant(["Login"]))
}
