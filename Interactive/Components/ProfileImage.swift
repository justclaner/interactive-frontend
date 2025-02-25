//
//  ProfileImage.swift
//  Interactive
//
//  Created by Justin Zou on 2/24/25.
//

import SwiftUI

struct ProfileImage: View {
    @Binding var url: String
    @Binding var sideLength: Double
    var body: some View {
        AsyncImage(url: URL(string: url)) {result in
            result.image?
                .resizable()
                .scaledToFill()
                .frame(width:CGFloat(sideLength),height:CGFloat(sideLength), alignment: .center)
                .clipped()
                .contentShape(Rectangle())
                .clipShape(RoundedRectangle(cornerRadius:CGFloat(sideLength)*0.2))
        }
    }
}

#Preview {
    ProfileImage(url: .constant("https://interactive-images.s3.us-east-1.amazonaws.com/e0301d9a-44d8-4dc5-a4ae-02cc00421ce4")
                 , sideLength: .constant(150))
}
