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
    @State private var path : [Int] = []
    var body: some View {
        NavigationStack(path:$path) {
        
            ZStack {
//            AngularGradient(colors: [
//                //Color.red, Color.blue
//                Helper.hexColor(hexCode: "#AF945F").opacity(0.3),
//                Helper.hexColor(hexCode: "#735E46").opacity(0.3),
//                Helper.hexColor(hexCode: "#AD7644").opacity(0.3),
//                Helper.hexColor(hexCode: "#FFF3B6").opacity(0.3)
//            ], center: .center, angle: .zero)
//            .blur(radius:100)
//            .rotationEffect(.degrees(155))
//            .frame(width:676,height:453)
//            .offset(x:0,y:-320)

            Color.white.opacity(0.001)
                .ignoresSafeArea()
                .onTapGesture() {
                    if (isLogging) {
                        isLogging.toggle()
                    }
                }
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
                                path = [1,2,3]
                                isLogging.toggle()
                            }) {
                                Text("login")
                                    .font(.system(size:17,weight:.bold))
                                    .tint(Color.black.opacity(0.75))
                                    .padding()
                                    .frame(maxWidth:.infinity,maxHeight:.infinity)
                            }
                            
                            .frame(width:253,height:41)
                            .background(Helper.hexColor(hexCode: "#FFDD1A"))
                            .clipShape(RoundedRectangle(cornerRadius:20))
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(.white.opacity(0.6), lineWidth: 1)
                            )
                            .padding([.vertical],10)
                            
                        
//                        if (!isLogging) {
//                            Button(action: {
//                                isLogging.toggle()
//                            }) {
//                                Text("login")
//                                    .font(.system(size:17,weight:.bold))
//                                    .tint(Color.black.opacity(0.75))
//                                    .padding(10)
//                            }
//                            .frame(width:253,height:41)
//                            .background(Helper.hexColor(hexCode: "#FFDD1A"))
//                            .clipShape(RoundedRectangle(cornerRadius:20))
//                            .overlay(RoundedRectangle(cornerRadius: 20)
//                                .stroke(.white.opacity(0.6), lineWidth: 1)
//                            )
//                            .padding([.vertical],10)
//                        } else {
//                            TextField("username/email",text:$username)
//                                .font(.system(size:16,weight:.regular))
//                                .tint(Color.black.opacity(0.75))
//                                .padding([.horizontal],20)
//                                .padding([.vertical],10)
//                                .frame(width:253,height:39)
//                                .background(Color.black.opacity(0.05))
//                                .clipShape(RoundedRectangle(cornerRadius:20))
//                                .overlay(RoundedRectangle(cornerRadius:20)
//                                    .stroke(.white.opacity(0.6), lineWidth:1)
//                                )
//                                .padding([.bottom],10)
//                            TextField("password",text:$password)
//                                .font(.system(size:16,weight:.regular))
//                                .tint(Color.black.opacity(0.75))
//                                .padding([.horizontal],20)
//                                .padding([.vertical],10)
//                                .frame(width:253,height:39)
//                                .background(Color.black.opacity(0.05))
//                                .clipShape(RoundedRectangle(cornerRadius:20))
//                                .overlay(RoundedRectangle(cornerRadius:20)
//                                    .stroke(.white.opacity(0.6), lineWidth:1)
//                                )
//                                .padding([.bottom],10)
//                        }
                        Button(action: {
                            //action
                        }) {
                            Text("create an account")
                                .font(.system(size:17,weight:.bold))
                                .tint(Color.black.opacity(0.75))
                                .padding(10)
                        }
                        .frame(width:253,height:41)
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
            .navigationDestination(for: Int.self) {
                pageNum in Text("You selected \(pageNum)")
            }
        }
    }
}

#Preview {
    LoginView()
}
