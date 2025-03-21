//
//  ProfileNetworks.swift
//  Interactive
//
//  Created by Justin Zou on 3/14/25.
//

import SwiftUI

struct ProfileNetworks: View {
    @Binding var networkLinks: [String]
    @Binding var iconWidth: CGFloat
    var body: some View {
        HStack {
            ForEach(0..<min(3, networkLinks.count), id: \.self) { index in
                Link(destination: URL(string: networkLinks[index])!) {
                    Image((String(Control.getDomainHost(from: networkLinks[index])!.dropFirst(4).dropLast(4))
                          ))
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width:iconWidth,
                        height:iconWidth,
                        alignment: .center)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: Control.getScreenSize().width * 0.03233830845))
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ProfileNetworks(networkLinks: .constant(["https://www.instagram.com/", "https://www.facebook.com/"]), iconWidth: .constant(CGFloat(Control.getScreenSize().width * 0.12437810945)))
}
