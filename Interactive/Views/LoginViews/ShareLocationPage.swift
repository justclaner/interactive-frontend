//
//  ShareLocationPage.swift
//  Interactive
//
//  Created by Justin Zou on 11/14/24.
//

import SwiftUI
import CoreLocation

struct ShareLocationPage: View {
    @Binding var path: [String]
    @EnvironmentObject var locationManager: LocationManager
    
    @State var requestedLocation: Bool = false
    
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
                   
                }
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                LargeLogo()
                    .padding([.top],30)
                Text("Share your location")
                    .font(.system(size:Control.mediumFontSize,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .padding([.vertical],Control.mediumHeight)
                    .frame(maxWidth:Control.maxWidth,alignment:.leading)
                
                Group {
                    Text("Interactive is based on presence. ")
                        .font(.system(size:Control.tinyFontSize,weight:.regular))
                        .foregroundStyle(Control.hexColor(hexCode: "#FFDD1A"))
                    +
                    Text("Location sharing is essential")
                        .font(.system(size:Control.tinyFontSize,weight:.regular))
                        .foregroundStyle(Control.hexColor(hexCode: "#E6E6E6"))
                }
                .frame(maxWidth:Control.maxWidth,alignment:.leading)
                .padding([.bottom],20)
                
                Group {
                    Text("There are no maps. ")
                        .font(.system(size:Control.tinyFontSize,weight:.regular))
                        .foregroundStyle(Control.hexColor(hexCode: "#FFDD1A"))
                    +
                    Text("No one will be able to see your movements or precise location.")
                        .font(.system(size:Control.tinyFontSize,weight:.regular))
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth:Control.maxWidth,alignment:.leading)
                .padding([.bottom],20)
                Group {
                    Text("You will only be able to see the people in the same area as you, ")
                        .font(.system(size:Control.tinyFontSize,weight:.regular))
                        .foregroundStyle(Control.hexColor(hexCode: "#E6E6E6"))
                    +
                    Text("without location or distance details.")
                        .font(.system(size:Control.tinyFontSize,weight:.regular))
                        .foregroundStyle(Control.hexColor(hexCode: "#FFDD1A"))
                }
                .frame(maxWidth:Control.maxWidth,alignment:.leading)
                Spacer()
                
                Button(action: {
                    if (!requestedLocation) {
                        locationManager.requestLocation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            requestedLocation = true
                        }
                    } else {
                        path.append("All Done")
                    }
                    }) {
                        Text(requestedLocation ? "Continue" : "Turn on localization")
                            .font(.system(size:Control.tinyFontSize,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#1A1A1A"))
                            .padding(10)
                            .frame(maxWidth:.infinity,maxHeight:.infinity)
                    }
                    .frame(width:Control.maxWidth,height:Control.mediumHeight)
                    .background(Control.hexColor(hexCode: "#FFDD1A"))
                    .clipShape(RoundedRectangle(cornerRadius:20))
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.6), lineWidth: 1)
                    )
//                Button(action: {
//                    path.append("All Done")
//                }) {
//                    Text("Not now")
//                        .font(.system(size:Control.smallFontSize,weight:.semibold))
//                        .foregroundStyle(Control.hexColor(hexCode: "#999999"))
//                        .padding()
//                }
            }
            .frame(maxWidth:Control.maxWidth)
        }
    }
}

#Preview {
    ShareLocationPage(path:.constant(["Login","About You","Add Email", "Share Location"]))
}
