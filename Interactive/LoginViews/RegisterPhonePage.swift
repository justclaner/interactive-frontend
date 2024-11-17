//
//  RegisterPhone.swift
//  Interactive
//
//  Created by Justin Zou on 11/17/24.
//

import SwiftUI

struct RegisterPhonePage: View {
    @Binding var path: [String]
    var body: some View {
        ZStack {
            Color.white.opacity(0.001)
                .ignoresSafeArea()
                .background(
                    Image("Background1")
                        .resizable()
                        .ignoresSafeArea()
                )
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                LargeLogo()
                    .padding([.top],30)
                Spacer()
            }
            .frame(maxWidth:361)
        }
    }
}

#Preview {
    RegisterPhonePage(path:.constant(["Register Phone"]))
}
