//
//  PlusIcon.swift
//  Interactive
//
//  Created by Justin Zou on 3/24/25.
//

import SwiftUI

struct PlusIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Control.hexColor(hexCode:"#333333"))
                .frame(width: 2 * Control.largeFontSize)
            Rectangle()
                .fill(Control.hexColor(hexCode:"#FFDD1A"))
                .frame(width: 0.75 * Control.largeFontSize, height: 0.35 * Control.tinyFontSize)
            Rectangle()
                .fill(Control.hexColor(hexCode:"#FFDD1A"))
                .frame(width: 0.35 * Control.tinyFontSize, height: 0.75 * Control.largeFontSize)
        }
    }
}

#Preview {
    PlusIcon()
}
