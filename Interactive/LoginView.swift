//
//  LoginView.swift
//  Interactive
//
//  Created by Justin Zou on 11/3/24.
//

import SwiftUI

struct LoginView: View {
    @State private var isLogging: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture() {
                    if (isLogging) {
                        isLogging.toggle()
                    }
                }
            
            VStack {
                Spacer()
                Text("i")
                    .font(.system(size:128,weight:.bold))
                    .frame(width:296,height:155)
                    //.position(x:(49 + 296/2),y:(289 + 155/2))
                    .padding([.bottom],-5)
                VStack {
                    if (!isLogging) {
                        Button(action: {
                            isLogging.toggle()
                        }) {
                            Text("create account")
                                .font(.system(size:17,weight:.bold))
                                .tint(Color.black.opacity(0.75))
                                .padding(10)
                        }
                        .frame(width:253,height:41)
                        .background(Color.black.opacity(0.17))
                        .clipShape(RoundedRectangle(cornerRadius:20))
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.6), lineWidth: 1)
                        )
                        .padding([.vertical],10)
                    } else {
                        TextField("username/email",text:$username)
                            .font(.system(size:16,weight:.regular))
                            .tint(Color.black.opacity(0.75))
                            .padding([.horizontal],20)
                            .padding([.vertical],10)
                            .frame(width:253,height:39)
                            .background(Color.black.opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius:20))
                            .overlay(RoundedRectangle(cornerRadius:20)
                                .stroke(.white.opacity(0.6), lineWidth:1)
                            )
                            .padding([.bottom],10)
                        TextField("password",text:$password)
                            .font(.system(size:16,weight:.regular))
                            .tint(Color.black.opacity(0.75))
                            .padding([.horizontal],20)
                            .padding([.vertical],10)
                            .frame(width:253,height:39)
                            .background(Color.black.opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius:20))
                            .overlay(RoundedRectangle(cornerRadius:20)
                                .stroke(.white.opacity(0.6), lineWidth:1)
                            )
                            .padding([.bottom],10)
                    }
                    Button(action: {
                        //action
                    }) {
                        Text("log in")
                            .font(.system(size:17,weight:.bold))
                            .tint(Color.black.opacity(0.75))
                            .padding(10)
                    }
                    .frame(width:253,height:41)
                    .background(Color.black.opacity(0.19))
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
    LoginView()
}
