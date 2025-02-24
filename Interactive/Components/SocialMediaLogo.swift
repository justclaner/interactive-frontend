//
//  SocialMediaLogo.swift
//  Interactive
//
//  Created by Justin Zou on 11/30/24.
//

import SwiftUI

struct SocialMediaLogo: View {
    @Binding var url: String
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
        }
    }
}

#Preview {
    SocialMediaLogo(url: .constant("https://www.instagram.com"))
}
