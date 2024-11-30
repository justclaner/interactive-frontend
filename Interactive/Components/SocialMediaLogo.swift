//
//  SocialMediaLogo.swift
//  Interactive
//
//  Created by Justin Zou on 11/30/24.
//

import SwiftUI

struct SocialMediaLogo: View {
    @Binding var platform: String
    var body: some View {
        Image(platform)
            .resizable()
            .scaledToFill()
            .frame(width:CGFloat(50),height:CGFloat(50), alignment: .center)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 13))
    }
}

#Preview {
    SocialMediaLogo(platform: .constant("instagram"))
}
