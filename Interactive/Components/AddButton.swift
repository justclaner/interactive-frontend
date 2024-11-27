//
//  AddButton.swift
//  Interactive
//
//  Created by Justin Zou on 11/26/24.
//

import SwiftUI

struct AddButton: View {
    @Binding var action: () -> Void
    @Binding var text: String
    @Binding var colorHex: String
    var body: some View {
        Button(action: action) {
            HStack {
                Text("\(text)")
                    .font(.system(size:13,weight:.regular))
                    .foregroundColor(Control.hexColor(hexCode: "#333333"))
                Image(systemName: "plus")
                    .font(.system(size:12))
                    .foregroundColor(Control.hexColor(hexCode: "#333333"))
            }
        }
        .padding([.horizontal],10)
        .frame(height:28)
        .background(Control.hexColor(hexCode: colorHex))
        .clipShape(RoundedRectangle(cornerRadius: 999))
    }
}

#Preview {
    AddButton(action: .constant({}), text: .constant("Add"), colorHex: .constant("#CCCCCC"))
}
