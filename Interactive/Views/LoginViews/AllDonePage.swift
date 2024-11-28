//
//  AllDonePage.swift
//  Interactive
//
//  Created by Justin Zou on 11/17/24.
//

import SwiftUI

struct AllDonePage: View {
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
                    .padding([.bottom],20)
                Text("You have everything you need!")
                    .font(.system(size:31,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding([.vertical],10)
                Group {
                    Text("You have entered in the basic information.")
                            .font(.system(size:16,weight:.regular))
                            .bold()
                            .foregroundStyle(Color.white)
                    +
                    Text(" To maximize your visibility and attract more contacts:")
                        .font(.system(size:16,weight:.regular))
                        .foregroundStyle(Control.hexColor(hexCode: "#E6E6E6"))
                }
                .padding([.vertical],10)
                .frame(maxWidth:361,alignment: .leading)
                HStack {
                    Text("Complete your profile")
                        .font(.system(size:16,weight:.bold))
                        .foregroundStyle(Control.hexColor(hexCode: "#FFE54D"))
                        .onTapGesture() {
                            path.append("Your Profile")
                        }
                        .padding([.trailing],10)
                    Image(systemName:"chevron.right")
                        .font(.system(size:12))
                        .foregroundStyle(Control.hexColor(hexCode:"#CCCCCC"))
                        .background(
                        Circle()
                            .fill(Control.hexColor(hexCode:"#333333"))
                            .frame(width:20,height:20)
                        )
                        .onTapGesture() {
                            //change path
                        }
                    Spacer()
                }
                .frame(maxWidth:361)
                Spacer()
            }
            .frame(maxWidth:361)
        }
    }
}

#Preview {
    AllDonePage(path:.constant(["Login","About You","Add Email", "Share Location", "All Done"]))
}
