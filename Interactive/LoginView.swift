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
            AngularGradient(colors: [
                //Color.red, Color.blue
                Helper.hexColor(hexCode: "#AF945F").opacity(0.3),
                Helper.hexColor(hexCode: "#735E46").opacity(0.3),
                Helper.hexColor(hexCode: "#AD7644").opacity(0.3),
                Helper.hexColor(hexCode: "#FFF3B6").opacity(0.3)
            ], center: .center, angle: .zero)
            .blur(radius:100)
            .rotationEffect(.degrees(155))
            .frame(width:676,height:453)
            .offset(x:0,y:-320)
                
            AngularGradient(colors: [
                Helper.hexColor(hexCode: "#AF945F").opacity(0.3),
                Helper.hexColor(hexCode: "#735E46").opacity(0.3),
                Helper.hexColor(hexCode: "#AD7644").opacity(0.3),
                Helper.hexColor(hexCode: "#FFF3B6").opacity(0.3)
            ], center: .center, angle: .zero)
            .blur(radius:100)
            .frame(width:755,height:720)
            .rotationEffect(.degrees(-70))
            .offset(x:100,y:200)
            
            Rectangle()
            .fill(Helper.hexColor(hexCode: "#3C3B3B").opacity(0.65))
            .blur(radius:100)
            .frame(width:281,height:224)
            .offset(x:120,y:-380)
        
            Rectangle()
            .fill(Helper.hexColor(hexCode: "#3C3B3B").opacity(0.65))
            .blur(radius:100)
            .frame(width:281,height:224)
            .offset(x:-200,y:350)

            Color.white.opacity(0)
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
