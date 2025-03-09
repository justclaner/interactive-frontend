//
//  SocialMediaLogo.swift
//  Interactive
//
//  Created by Justin Zou on 11/30/24.
//

import SwiftUI

struct SocialMediaLogo: View {
    @Binding var url: String
    
    let xIconSize = Control.getScreenSize().width * 0.05
    let xIconCircleWidth = Control.getScreenSize().width * 0.06
    
    @State var linkClicked: Bool = false
    
    var body: some View {
        ZStack {
            Link(destination: URL(string: url)!) {
                Image((String(Control.getDomainHost(from: url)!.dropFirst(4).dropLast(4))
                      ))
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width:CGFloat(Control.getScreenSize().width * 0.12437810945),
                        height:CGFloat(Control.getScreenSize().width * 0.12437810945),
                        alignment: .center)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: Control.getScreenSize().width * 0.03233830845))
            }
//            Image("x-icon")
//                .resizable()
//                .frame(width:xIconSize, height:xIconSize)
//                .background(
//                    Circle()
//                        .fill(Color.white)
//                        .opacity(0.5)
//                        .frame(width: xIconCircleWidth, height: xIconCircleWidth)
//                )
//                .offset(x: (xIconSize + xIconCircleWidth * 0.9) / 2, y: -(xIconSize + xIconCircleWidth * 0.9) / 2)
//                .confirmationDialog("deleteLink:\(url)", isPresented: $linkClicked) {
//                    Button("Delete") {
//                        print("delete")
//                    }
//                    Button("Change Picture") {
//                        print("change picture")
//                    }
//                }
        }
    }
}

#Preview {
    SocialMediaLogo(url: .constant("https://www.instagram.com"))
}
