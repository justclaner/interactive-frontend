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
                Image("chevron-back")
                    .resizable()
                    .frame(width:30,height:30)
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
