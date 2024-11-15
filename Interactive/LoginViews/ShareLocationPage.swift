//
//  ShareLocationPage.swift
//  Interactive
//
//  Created by Justin Zou on 11/14/24.
//

import SwiftUI

struct ShareLocationPage: View {
    @Binding var path: [String]
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
                    //add
                }
            VStack {
                Button(action: {
                    path.removeLast()
                }) {
                    Image("chevron-back")
                        .resizable()
                        .frame(width:30,height:30)
                }
                .padding([.trailing],10)
                .frame(maxWidth:.infinity,alignment:.leading)
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
                Text("Share your location")
                    .font(.system(size:31,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .padding([.vertical],40)
                    .frame(maxWidth:361,alignment:.leading)
                Text("Interactive is based on presence.")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Helper.hexColor(hexCode: "#FFDD1A"))
                    .frame(maxWidth:361,alignment:.leading)
                Text("Location sharing is essential")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Helper.hexColor(hexCode: "#E6E6E6"))
                    .frame(maxWidth:361,alignment:.leading)
                    .padding([.bottom],20)
                Text("There is no map:")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Helper.hexColor(hexCode: "#FFDD1A"))
                    .frame(maxWidth:361,alignment:.leading)
                Text("No one will be able to see your movements or precise location.")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                    .padding([.bottom],20)
                Group {
                    Text("You will only be able to see the people in the same area as you, ")
                        .font(.system(size:16,weight:.regular))
                        .foregroundStyle(Helper.hexColor(hexCode: "#E6E6E6"))
                    +
                    Text("without location or distance details.")
                        .font(.system(size:16,weight:.regular))
                        .foregroundStyle(Helper.hexColor(hexCode: "#FFDD1A"))
                }
                .frame(maxWidth:361,alignment:.leading)
                Spacer()
                Button(action: {
                    //action
                }) {
                    Text("Turn on localization")
                        .font(.system(size:17,weight:.semibold))
                        .foregroundStyle(Helper.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:361,height:40)
                .background(Helper.hexColor(hexCode: "#FFDD1A"))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
                Button(action: {
                    
                }) {
                    Text("Not now")
                        .font(.system(size:16,weight:.semibold))
                        .foregroundStyle(Helper.hexColor(hexCode: "#999999"))
                        .padding()
                }
            }
            .frame(maxWidth:361)
        }
    }
}

#Preview {
    ShareLocationPage(path:.constant(["Login","About You","Add Email", "Share Location"]))
}
