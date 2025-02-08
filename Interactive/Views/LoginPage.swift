//
//  LoginView.swift
//  Interactive
//
//  Created by Justin Zou on 11/3/24.
//

import SwiftUI

struct LoginPage: View {
    
    @Binding var path : [String]
    //@Binding var data : UserData
    
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
                        print("test")
                        print(data.getLocation())
                        print(data.incrementCounter())
                        print(data.getCounter())
                        //testCall()
                    }
                
                VStack {
                    Spacer()
                    VStack{
                        Circle()
                            .fill(Control.hexColor(hexCode: "#FFDD1A"))
                            .frame(width:16,height:16)
                            .padding([.bottom],-4)
                        Rectangle()
                            .fill(Control.hexColor(hexCode: "#FFDD1A"))
                            .frame(width:16,height:52)
                            .clipShape(RoundedRectangle(cornerRadius:12.11))
                            .padding([.bottom],10)
                        
                    }
                    .background(
                        Circle()
                            .fill(Control.hexColor(hexCode:"#333333"))
                            .frame(width:113,height:113)
                    )
                    .offset(x:0,y:-40)
                    VStack {
                        Button(action: {
                            path.append("Welcome Back")
                        }) {
                            Text("login")
                                .font(.system(size:17,weight:.bold))
                                .foregroundStyle(Color.black.opacity(0.75))
                                .padding()
                                .frame(maxWidth:.infinity,maxHeight:.infinity)
                        }
                        
                        .frame(width:361,height:40)
                        .background(Control.hexColor(hexCode: "#FFDD1A"))
                        .clipShape(RoundedRectangle(cornerRadius:20))
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.6), lineWidth: 1)
                        )
                        .padding([.vertical],10)
                     
                        Button(action: {
                            path.append("About You")
                        }) {
                            Text("create an account")
                                .font(.system(size:17,weight:.bold))
                                .foregroundStyle(Color.black.opacity(0.75))
                                .padding(10)
                                .frame(maxWidth:.infinity,maxHeight:.infinity)
                        }
                        .frame(width:361,height:40)
                        .background(Control.hexColor(hexCode: "#FFDD1A"))
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
    LoginPage(path:.constant(["Login"])
              //data: .constant( UserData())
    )
}
