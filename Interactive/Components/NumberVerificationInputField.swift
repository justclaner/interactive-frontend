//
//  VerifyNumField.swift
//  Interactive
//
//  Created by Justin Zou on 11/24/24.
//

import SwiftUI

struct NumberVerificationInputField: View {
    @Binding var inputPointer: String
    var body: some View {
        Text("\(inputPointer)")
            .font(.system(size:32,weight:.semibold))
            .overlay(Rectangle().frame(width: 32, height: 1, alignment: .bottom).foregroundStyle(Color.white), alignment: .bottom)
            .foregroundStyle(Color.white)
            .frame(maxWidth:32)
    }
}

#Preview {
    NumberVerificationInputField(inputPointer: .constant(" "))
}
