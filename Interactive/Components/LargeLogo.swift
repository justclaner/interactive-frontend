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
                .frame(width:16,height:14)
                .padding([.bottom],-4)
            Rectangle()
                .fill(Control.hexColor(hexCode: "#FFDD1A"))
                .frame(width:16,height:52)
                .clipShape(RoundedRectangle(cornerRadius:12.11))
                .padding([.bottom],10)
        }
            .background(
                Circle()
                    .fill(Control.hexColor(hexCode:"#333333"))
                    .frame(width:113,height:113)
            )
    }
}

#Preview {
    LargeLogo()
}
