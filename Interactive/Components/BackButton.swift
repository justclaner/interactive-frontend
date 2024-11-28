//
//  BackButton.swift
//  Interactive
//
//  Created by Justin Zou on 11/17/24.
//

import SwiftUI

struct BackButton: View {
    @Binding var path: [String]
    var body: some View {
        VStack {
            Button(action: {
                    path.removeLast()
            }) {
                Image(systemName:"chevron.left")
                    .font(.system(size:20))
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth:.infinity,alignment:.leading)
            Spacer()
        }
        .frame(maxWidth:361)
    }
}

#Preview {
    BackButton(path:.constant(["Login"]))
}
