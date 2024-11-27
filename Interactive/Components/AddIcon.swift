//
//  AddImage.swift
//  Interactive
//
//  Created by Justin Zou on 11/26/24.
//

import SwiftUI

struct AddIcon: View {
    @Binding var sideLength: Double
    var body: some View {
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

#Preview {
    AddIcon(sideLength: .constant(100))
}
