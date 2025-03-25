//
//  Logo.swift
//  Interactive
//
//  Created by Justin Zou on 11/17/24.
//

import SwiftUI

struct LargeLogo: View {
    var body: some View {
        VStack{
            Ellipse()
                .fill(Control.hexColor(hexCode: "#FFDD1A"))
                .frame(width:1.05 * Control.tinyFontSize,height:Control.tinyFontSize)
                .padding([.bottom],-0.25 * Control.tinyFontSize)
                .padding([.top],0.5 * Control.tinyFontSize)
            Rectangle()
                .fill(Control.hexColor(hexCode: "#FFDD1A"))
                .frame(width:1.05 * Control.tinyFontSize,height: 1.35 * Control.largeFontSize)
                .clipShape(RoundedRectangle(cornerRadius:0.6 * Control.tinyFontSize))
                .padding([.bottom],0.5 * Control.tinyFontSize)
        }
            .background(
                Circle()
                    .fill(Control.hexColor(hexCode:"#333333"))
                    .frame(width:3 * Control.largeFontSize,height:3 * Control.largeFontSize)
            )
    }
}

#Preview {
    LargeLogo()
}
