//
//  NavigationBar.swift
//  Interactive
//
//  Created by Justin Zou on 11/26/24.
//

import SwiftUI

struct NavigationBar: View {
    @State var activePresence: Bool = false
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Control.hexColor(hexCode: "#1A1A1A").opacity(0.65))
                    .frame(maxWidth:.infinity,maxHeight:Control.navigationBarHeight)
                    .ignoresSafeArea()
                    .onTapGesture {
                        print(Control.getScreenSize().width*0.17412935323)
                    }
                HStack {
                    Image("home_blank")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(width: Control.navigationIconSize, height: Control.navigationIconSize)
                    Spacer()
                    Image("bell_blank")
                        .resizable()
                        .frame(width: Control.navigationIconSize, height: Control.navigationIconSize)
                    Spacer()
                    VStack{
                        Ellipse()
                            .fill(Control.hexColor(hexCode: activePresence ? "#FFDD1A" : "#999999"))
                            .frame(width:Control.navigationBarHeight * 0.08,height:Control.navigationBarHeight * 0.075)
                            .padding([.bottom],-0.035 * Control.navigationBarHeight)
                            .padding([.top],0.02 * Control.navigationBarHeight)
                        Rectangle()
                            .fill(Control.hexColor(hexCode: activePresence ? "#FFDD1A" : "#999999"))
                            .frame(width:Control.navigationBarHeight * 0.08,height:Control.navigationBarHeight * 0.25)
                            .clipShape(RoundedRectangle(cornerRadius:12.11))
                            .padding([.bottom],Control.navigationBarHeight * 0.05)
                    }
                        .background(
                            Circle()
                                .fill(Control.hexColor(hexCode:"#333333"))
                                .frame(width:Control.navigationBarHeight * 0.6 ,height:Control.navigationBarHeight * 0.6)
                        )
                        .frame(maxWidth:Control.navigationBarHeight * 0.6)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration:0.25)) {
                                activePresence.toggle()
                            }
                        }
                        .transition(.opacity)
                    Spacer()
                    Image("feed_blank")
                        .resizable()
                        .frame(width: Control.navigationIconSize, height: Control.navigationIconSize)
                    Spacer()
                    Image(UserDefaults.standard.bool(forKey: "inProfile") ? "settings_full" : "settings_blank")
                        .resizable()
                        .frame(width: Control.navigationIconSize, height: Control.navigationIconSize)
                        .onTapGesture {
                            let inProfile = UserDefaults.standard.bool(forKey: "inProfile")
                            UserDefaults.standard.set(!inProfile, forKey: "inProfile")
                        }
                }
                .padding()
                .frame(maxWidth:.infinity,maxHeight:Control.navigationBarHeight)
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationBar()
}
