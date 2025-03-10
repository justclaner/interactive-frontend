//
//  UpdateNetworkPage.swift
//  Interactive
//
//  Created by Justin Zou on 3/9/25.
//

import SwiftUI

struct UpdateNetworkPage: View {
    @Binding var path: [String]
    
    @State var networkLink: String = UserDefaults.standard.string(forKey: "tempNetworkLink") ?? ""
    @State var warning: String = "c"
    @State var showWarning: Bool = false
    @FocusState var networkLinkFocus: Bool
    
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
//                    print(Control.getDomainHost(from: networkLink) ?? "")
//                    print(Control.getScreenSize().width)
                    networkLinkFocus = false
                    showWarning = false
                }
            BackButton(path:$path)
            VStack {
                Text("Network")
                    .font(.system(size:Control.mediumFontSize, weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(width: Control.maxWidth, alignment: .center)
                Text("Update one of your social media links!")
                    .font(.system(size:Control.tinyFontSize, weight:.medium))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: Control.maxWidth, alignment:.leading)
                    .padding([.top],5)
                    .padding([.bottom],20)
                Text("Link:")
                    .font(.system(size:Control.tinyFontSize, weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: Control.maxWidth, alignment:.leading)
                TextField("", text: $networkLink, prompt: Text(verbatim: "https://www.instagram.com/username")
                    .font(.system(size:Control.tinyFontSize,weight:.semibold))
                    .foregroundColor(Control.hexColor(hexCode: "#B3B3B3")))
                    .foregroundStyle(.white)
                    .padding(Control.tinyFontSize)
                    .frame(width:Control.maxWidth,height:Control.maxHeight)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundColor(Control.hexColor(hexCode: "#B3B3B3"))
                    .padding([.bottom],10)
                    .focused($networkLinkFocus)
                
                if (networkLink.count >= 20
                    && (networkLink.hasPrefix("https://") || networkLink.hasPrefix("http://"))
                    && Control.socialMediaPlatforms.contains(
                        String(Control.getDomainHost(from: networkLink)!.dropFirst(4).dropLast(4))
                    )
                    && Control.getDomainHost(from: networkLink) != nil
                ) {
                    SocialMediaLogo(url: $networkLink)
                }
                Spacer()
                Text(warning)
                    .font(.system(size:Control.tinyFontSize, weight:.bold))
                    .foregroundStyle(Color.red)
                    .opacity(showWarning ? 1 : 0.01)
                    .frame(maxWidth: Control.maxWidth,alignment:.leading)
                    .offset(x:0,y:3)
                Button(action: {
                    if (networkLink.count < 20) {
                        warning = "Link is not valid! (Too short to be a link)"
                        showWarning = true
                    } else {
                        if (!networkLink.hasPrefix("http://") && !networkLink.hasPrefix("https://")) {
                            warning = "Link is not valid! (Must start with 'http://' or 'https://')"
                        showWarning = true
                            return
                        }
                        let platform = String(Control.getDomainHost(from: networkLink)!.dropFirst(4).dropLast(4))
                        
                        if (!Control.socialMediaPlatforms.contains(platform)) {
                            warning = "Link is not valid! (Not a supported social media platform)"
                            showWarning = true
                            return
                        } else {
                            Task {
                                do {
                                    let updateNetworkLink = try await APIClient.updateLink(oldUrl: UserDefaults.standard.string(forKey: "tempNetworkLink") ?? "", platform: platform, newUrl: networkLink)
                                    UserDefaults.standard.set("", forKey: "tempNetworkLink")
                                    if (!updateNetworkLink.success) {
                                        warning = "Either there already is a network link for this platform, the link you provided is invalid, or the server is down."
                                        showWarning = true
                                    } else {
                                        UserDefaults.standard.set(true, forKey: "addedLink")
                                        path = ["Your Profile"]
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    }
                }) {
                    Text("Update Network Link")
                        .font(.system(size:17,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width: Control.maxWidth,height:Control.mediumHeight)
                .background(Control.hexColor(hexCode: "#FFDD1A"))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
                .padding([.top],5)
            }
          //  .padding([.top], Control.largeFontSize*1.5)
        }
    }
    
    func getDomainHost(from link: String) -> String? {
        guard let urlComponents = URLComponents(string: link) else { return nil }
        return urlComponents.host
    }
}

#Preview {
    UpdateNetworkPage(path: .constant(["Your Profile", "Edit Network"]))
        .ignoresSafeArea(.keyboard)
}
