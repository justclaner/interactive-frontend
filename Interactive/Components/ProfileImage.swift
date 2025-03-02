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
    @Binding var imageNumber: Int
    
    let xIconSize = Control.getScreenSize().width * 0.06
    let xIconCircleWidth = Control.getScreenSize().width * 0.08
    var body: some View {
            if (url != "") {
                ZStack {
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
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius:CGFloat(sideLength)*0.2)
                        .fill(Control.hexColor(hexCode:"#999999"))
                        .frame(width:CGFloat(sideLength),height:CGFloat(sideLength))
                    Image(systemName:"plus")
                        .font(.system(size:sideLength*0.5))
                        .foregroundStyle(Control.hexColor(hexCode:"#CCCCCC"))
                }
            }
    }
        
}

#Preview {
    ProfileImage(url: .constant("")
                 ,sideLength: .constant(150)
                 ,imageNumber: .constant(1))
}
