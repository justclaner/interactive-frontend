//
//  BackButton.swift
//  Interactive
//
//  Created by Justin Zou on 11/17/24.
//

import SwiftUI

struct BackButton: View {
    @Binding var path: [String]
    let maxWidth: CGFloat = Control.getMaxWidth()
    var body: some View {
        VStack {
            Button(action: {
                    path.removeLast()
            }) {
                Image(systemName:"chevron.left")
                    .font(.system(size: Control.getScreenSize().width * 0.04975124378))
                    .foregroundStyle(Color.white)
                    .frame(width: Control.getScreenSize().width * 0.07462686567, height: Control.getScreenSize().width * 0.07462686567)
            }
            .frame(maxWidth:.infinity,alignment:.leading)
            Spacer()
        }
        .frame(maxWidth:maxWidth)
    }
}

#Preview {
    BackButton(path:.constant(["Login"]))
}
