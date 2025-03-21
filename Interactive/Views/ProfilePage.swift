//
//  ProfilePage.swift
//  Interactive
//
//  Created by Justin Zou on 3/18/25.
//

import SwiftUI

struct ProfilePage: View {
    @Binding var path: [String]
    @State var userId: String
    @State var username: String = "random username"
    @State var bio: String = "hi am a random user"
    @State var visitors: Int = 0
    @State var interactions: Int = 0
    @State var imageLinks: [String] = ["https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg"]
    @State var networkLinks: [String] = ["https://www.instagram.com/", "https://www.facebook.com/"]
    @State var interactStatus: String = "Interact"
    @State var interactButtonColor: Color = Color.white.opacity(0.55)
    
    init(path: Binding<[String]>) {
        self._path = path
        self._userId = State(initialValue:
        (path.wrappedValue.last != nil && path.wrappedValue.last!.count > 8)
            ? String(path.wrappedValue.last!.dropFirst(8))
            : ""
        )
    }
    
    let imageSquareWidth = Control.maxWidth * 0.42
    
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
                }
            BackButton(path:$path)
                .padding([.top],8)
            VStack(spacing: Control.tinyFontSize) {
                Text(username)
                    .font(.system(size:Control.mediumFontSize, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding([.trailing], Control.smallFontSize)
                
                ScrollView(.horizontal) {
                    HStack(spacing: Control.smallFontSize) {
                        ForEach(0..<imageLinks.count, id: \.self) { index in
                            AsyncImage(url:URL(string:imageLinks[index])) {phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: imageSquareWidth, height: imageSquareWidth)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: Control.mediumFontSize)
                                        )
                                } else {
                                    RoundedRectangle(cornerRadius: Control.mediumFontSize)
                                        .fill(Color.gray)
                                        .frame(width: imageSquareWidth, height: imageSquareWidth)
                                }
                            }
                        }
                    }
                    .padding([.leading], Control.smallFontSize)
                }
                
                HStack {
                    VStack {
                        Text("Visitors")
                            .font(.system(size: Control.smallFontSize, weight: .bold))
                            .foregroundStyle(Color.white)
                        Text("\(visitors)")
                            .font(.system(size: Control.mediumFontSize, weight: .bold))
                            .frame(maxWidth: "Visitorss".size(withAttributes: [.font: UIFont.systemFont(ofSize: Control.smallFontSize)]).width, alignment: .leading)
                            .foregroundStyle(Color.white)
                    }
                    //.border(Color.red, width: 2)
                    VStack {
                        Text("Interactions")
                            .font(.system(size: Control.smallFontSize, weight: .bold))
                            .foregroundStyle(Color.white)
                        Text("\(interactions)")
                            .font(.system(size: Control.mediumFontSize, weight: .bold))
                            .frame(maxWidth: "Interactionss".size(withAttributes: [.font: UIFont.systemFont(ofSize: Control.smallFontSize)]).width, alignment: .leading)
                            .foregroundStyle(Control.hexColor(hexCode: "#FFDD1A"))
                    }
                    //.border(Color.red, width: 2)
                    Spacer()
                }
                .padding([.leading], Control.smallFontSize)
                
                VStack {
                    Text("About Me")
                        .font(.system(size: Control.tinyFontSize, weight: .bold))
                        .foregroundStyle(Color.white).opacity(0.65)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    Text(bio)
                        .font(.system(size: Control.tinyFontSize, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                .padding([.leading], Control.smallFontSize)
                
                VStack {
                    Text("Network")
                        .font(.system(size: Control.tinyFontSize, weight: .bold))
                        .foregroundStyle(Color.white).opacity(0.65)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    ProfileNetworks(networkLinks: $networkLinks, iconWidth: .constant(CGFloat(Control.getScreenSize().width * 0.14)))
                        .padding([.top], -0.3 * Control.tinyFontSize)
                }
                .padding([.leading], Control.smallFontSize)
                
                Spacer()
                Button(action: {
                }) {
                    Text(interactStatus)
                        .font(.system(size:1.3 * Control.tinyFontSize,weight:.semibold))
                        .foregroundStyle(Color.white)
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:Control.maxWidth,height: Control.mediumHeight)
                .background(interactButtonColor)
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
                .padding([.bottom], Control.navigationBarHeight)
            }
            
            NavigationBar()
        }
    }
}

#Preview {
    ProfilePage(path: .constant(["profile-67d45cbd2f34df445d2b0d78"]))
}
