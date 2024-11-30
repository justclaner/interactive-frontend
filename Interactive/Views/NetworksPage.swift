//
//  NetworksPage.swift
//  Interactive
//
//  Created by Justin Zou on 11/29/24.
//
// Interests filter

import SwiftUI
import Foundation

struct NetworksPage: View {
    @Binding var path: [String]
    
    @State var filterText: String = ""
    @FocusState var filterFocus: Bool
    @State var selectedPlatforms: [String] = Control.socialMediaPlatforms.map(\.self)
    var body: some View {
        ZStack {
            Color.white.opacity(0.001)
                .ignoresSafeArea()
                .background(
                    Image("Background1")
                        .resizable()
                        .ignoresSafeArea()
                )
                .onTapGesture {
                    filterFocus = false
                    print(filterText)
                    print(Int(floor(Double(selectedPlatforms.count)/6)))
                }
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                Text("Network")
                    .font(.system(size:20,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                    .padding([.top],18)
                    .padding([.leading],30)
                TextField("", text:$filterText, prompt:Text("Search...")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Control.hexColor(hexCode: "#333333"))
                )
                    .padding([.vertical],8)
                    .padding([.leading,.trailing],16)
                    .background(Control.hexColor(hexCode: "#666666"))
                    .clipShape(RoundedRectangle(cornerRadius:999))
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Control.hexColor(hexCode: "#333333"))
                    .focused($filterFocus)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .onChange(of: filterText) {
                        if (filterText == "") {
                            selectedPlatforms = Control.socialMediaPlatforms.map(\.self)
                        } else {
                            selectedPlatforms = Control.socialMediaPlatforms.filter {
                                $0.contains(filterText)
                            }
                        }
                    }
                ForEach(0..<Int(floor(Double(selectedPlatforms.count)/6))) {row in
                    HStack {
                        SocialMediaLogo(platform: .constant(selectedPlatforms[row*6]))
                        SocialMediaLogo(platform: .constant(selectedPlatforms[row*6+1]))
                        SocialMediaLogo(platform: .constant(selectedPlatforms[row*6+2]))
                        SocialMediaLogo(platform: .constant(selectedPlatforms[row*6+3]))
                        SocialMediaLogo(platform: .constant(selectedPlatforms[row*6+4]))
                        SocialMediaLogo(platform: .constant(selectedPlatforms[row*6+5]))
                    }
                }
                HStack {
                    ForEach(0..<Int(selectedPlatforms.count%6)) {i in
                        let index = Int(floor(Double(selectedPlatforms.count)/6))*6 + i
                        SocialMediaLogo(platform: .constant(selectedPlatforms[index]))
                    }
                }

                Spacer()
            }
            .frame(maxWidth:361)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    NetworksPage(path: .constant([""]))
}
