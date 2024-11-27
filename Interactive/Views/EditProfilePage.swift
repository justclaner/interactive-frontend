//
//  ProfilePage.swift
//  Interactive
//
//  Created by Justin Zou on 11/26/24.
//

import SwiftUI

struct EditProfilePage: View {
    @State var largeSideLength = 174.0
    @State var mediumSideLength = 81.0
    @State var smallSideLength = 50.0
    @Binding var path: [String]
    @State var visitors: Int = 0
    @State var interactions: Int = 0
    @State var aboutMe: String = ""
    @FocusState var aboutMeFocus: Bool
    @State var add: String = "Add"
    @State var addInsight: String = "Add New Insight"
    @State var gray_80: String = "#CCCCCC"
    @State var accent: String = "#FFDD1A"
    
    //change later
    @State var testFunc: () -> Void = {}
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
                    aboutMeFocus = false
                }
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                Text("Username")
                    .font(.system(size:25,weight:.semibold))
                    .padding([.top],20)
                HStack {
                    AddIcon(sideLength:$largeSideLength)
                    Spacer()
                    HStack {
                        VStack {
                            AddIcon(sideLength:$mediumSideLength)
                            Spacer()
                            AddIcon(sideLength:$mediumSideLength)
                        }
                        .frame(maxHeight:174)
                        Spacer()
                        VStack {
                            AddIcon(sideLength:$mediumSideLength)
                            Spacer()
                            AddIcon(sideLength:$mediumSideLength)
                        }
                        .frame(maxHeight:174)
                    }.frame(width:174)
                }
                HStack {
                    VStack {
                        Text("Visitors")
                            .font(.system(size:16,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#E6E6E6"))
                        Text("\(visitors)")
                            .font(.system(size:16,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#E6E6E6"))
                            .frame(width:59,alignment:.leading)
                    }
                    VStack {
                        Text("Interactions")
                            .font(.system(size:16,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#E6E6E6"))
                        Text("\(interactions)")
                            .font(.system(size:16,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#E6E6E6"))
                            .frame(width:91,alignment:.leading)
                    }
                    .padding([.leading],10)
                    Spacer()
                }
                .frame(maxWidth:361)
                .padding([.vertical],20)
                Text("About Me")
                    .font(.system(size:13,weight:.semibold))
                    .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                    .frame(width:361,alignment:.leading)
                TextField("", text: $aboutMe)
                    .padding([.leading,.trailing],10)
                    .frame(width:361,height:25)
                    .font(.system(size:13,weight:.regular))
                    .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                    .background(Control.hexColor(hexCode: "#4D4D4D"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .focused($aboutMeFocus)
                    .padding([.bottom],10)
                Text("Network")
                    .font(.system(size:13,weight:.semibold))
                    .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                    .frame(width:361,alignment:.leading)
                HStack {
                    AddIcon(sideLength:$smallSideLength)
                    Spacer()
                }
                VStack {
                    Text("Interests")
                        .font(.system(size:13,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                        .frame(width:361,alignment:.leading)
                        .padding([.top],10)
                    HStack {
                        AddButton(action:$testFunc, text: $add, colorHex:$gray_80)
                        Spacer()
                    }
                    Text("Jobs")
                        .font(.system(size:13,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                        .frame(width:361,alignment:.leading)
                        .padding([.top],10)
                    HStack {
                        AddButton(action:$testFunc, text: $add, colorHex:$gray_80)
                        Spacer()
                    }
                    Text("Interaction Goals")
                        .font(.system(size:13,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                        .frame(width:361,alignment:.leading)
                        .padding([.top],10)
                    HStack {
                        AddButton(action:$testFunc, text: $add, colorHex:$gray_80)
                        Spacer()
                    }
                    HStack {
                        AddButton(action:$testFunc, text: $addInsight, colorHex:$accent)
                        Spacer()
                    }
                    .padding([.top],20)
                }
                Spacer()
            }
            .frame(maxWidth:361)
            Image("pencil_edit")
                .resizable()
                .frame(width:20,height:20)
                .position(x:390,y:37)
            NavigationBar()
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    EditProfilePage(path: .constant(["Profile Page"]))
}
