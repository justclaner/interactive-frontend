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
    @State var visitors: Int = 0
    @State var interactions: Int = 0
    @State var aboutMe: String = ""
    @State var add: String = "Add"
    @State var addInsight: String = "Add New Insight"
    @State var gray_80: String = "#CCCCCC"
    @State var accent: String = "#FFDD1A"
    @State var testFunc: () -> Void = {
        print("hi")
    } //add real functions later
    
    @State var username = ""
    
    @Binding var path: [String]
    @FocusState var aboutMeFocus: Bool
    @FocusState var usernameFocus: Bool
    
    @State var inTutorial: Bool = ProfileSetup.inTutorial
    @State var tutorialStep: Int = ProfileSetup.tutorialStep
    @State var createdUsername: Bool = ProfileSetup.createdUsername
    @State var addedImage: Bool = ProfileSetup.addedImage
    
    @State var image1: Image?
    @State var image2: Image?
    @State var image3: Image?
    @State var image4: Image?
    @State var image5: Image?
//    @State var viewBoolList: [Bool] = [
//        ProfileSetup.inTutorial && ProfileSetup.tutorialStep != 0,
//    ]
//    
//    @State var guideBoolList: [Bool] = [
//        ProfileSetup.tutorialStep == 0,
//    ]
    
    
    var body: some View {
        //avoid keyboard pushing things up
        GeometryReader {geometry in
            ZStack {
                Color.white.opacity(0.001)
                    .ignoresSafeArea()
                    .background(
                        Color.black.opacity(inTutorial ? ProfileSetup.tutorialBlackOpacity : 0)
                    )
                    .background(
                        Image("Background1")
                            .resizable()
                            .ignoresSafeArea()
                    )
                    .onTapGesture {
                        usernameFocus = false
                        aboutMeFocus = false
                        print(tutorialStep)
                    }
                BackButton(path:$path)
                    .padding([.top],20)
                    .opacity(ProfileSetup.tutorialWhiteOpacity)
                
                //step 1
                Image("pencil_edit")
                    .resizable()
                    .frame(width:20,height:20)
                    .position(x:390,y:37)
                    .onTapGesture {
                        if (!(inTutorial && tutorialStep != 0)) {
                            usernameFocus.toggle()
                        }
                    }
                    .opacity((inTutorial && tutorialStep != 0) ? ProfileSetup.tutorialWhiteOpacity : 1)
                VStack {
                    TextField("", text:$username,
                              prompt:Text(usernameFocus ? "" : "Username")
                        .font(.system(size:25,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                    )
                    .multilineTextAlignment(.center)
                    .font(.system(size:25,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .padding([.top],15)
                    .focused($usernameFocus)
                    .opacity((inTutorial && tutorialStep != 0) ? ProfileSetup.tutorialWhiteOpacity : 1)
                    .disabled(ProfileSetup.inTutorial && ProfileSetup.tutorialStep != 0)
                    .onChange(of: username) {
                        self.username = String(username.prefix(16))
                        ProfileSetup.createdUsername = true
                    }
                    
                    
                    
                    //step 2
                    HStack {
                        AddImageIcon(image: $image1, imageNumber: .constant(0), sideLength:$largeSideLength)
                        Spacer()
                        HStack {
                            VStack {
                                AddImageIcon(image: $image2, imageNumber: .constant(1), sideLength:$mediumSideLength)
                                Spacer()
                                AddImageIcon(image: $image3, imageNumber: .constant(2), sideLength:$mediumSideLength)
                            }
                            .frame(maxHeight:174)
                            Spacer()
                            VStack {
                                AddImageIcon(image: $image4, imageNumber: .constant(3), sideLength:$mediumSideLength)
                                Spacer()
                                AddImageIcon(image: $image5, imageNumber: .constant(4), sideLength:$mediumSideLength)
                            }
                            .frame(maxHeight:174)
                        }.frame(width:174)
                    }
                    .opacity((inTutorial && tutorialStep != 1) ?
                             ProfileSetup.tutorialWhiteOpacity : 1)
                    
                    
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
                    .opacity(ProfileSetup.tutorialWhiteOpacity)
                    
                    VStack {
                        Text("About Me")
                            .font(.system(size:13,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                            .frame(width:361,alignment:.leading)
                        TextField("", text: $aboutMe)
                            .focused($aboutMeFocus)
                            .padding([.leading,.trailing],10)
                            .frame(width:361,height:25)
                            .font(.system(size:13,weight:.regular))
                            .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                            .background(Control.hexColor(hexCode: "#4D4D4D"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding([.bottom],10)
                    }
                    .opacity(ProfileSetup.tutorialWhiteOpacity)
                    
                    VStack {
                        Text("Network")
                            .font(.system(size:13,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                            .frame(width:361,alignment:.leading)
                        HStack {
                            AddNetworkIcon(sideLength:$smallSideLength)
                            Spacer()
                        }
                    }
                    .opacity(ProfileSetup.tutorialWhiteOpacity)
                    
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
                    .opacity(ProfileSetup.tutorialWhiteOpacity)
                    Spacer()
                }
                .frame(maxWidth:361)
                NavigationBar()
                    .opacity(ProfileSetup.tutorialWhiteOpacity)
                
                
                //step 1
                VStack {
                    Text("Tap \"Username\" or the pencil icon to edit your username.")
                        .font(.system(size:16,weight:.regular))
                        .frame(maxWidth:geometry.size.width*0.8)
                        .padding([.top],60)
                        .opacity(tutorialStep == 0 ? 1 : 0)
                    Spacer()
                }
                
                //step 2
                VStack {
                    Group {
                        Text("Insert at least one photo of yourself to continue.")
                            .foregroundStyle(Control.hexColor(hexCode: accent))
                        +
                        Text("It is important that others recognize you!")
                    }
                        .font(.system(size:16,weight:.regular))
                        .frame(maxWidth:geometry.size.width*0.8)
                        .padding([.top],240)
                        .opacity(tutorialStep == 1 ? 1 : 0)
                    Spacer()
                }
            }
            .onChange(of: usernameFocus) { //step 1
                if (ProfileSetup.createdUsername && ProfileSetup.tutorialStep == 0) {
                    print("username changed")
                    ProfileSetup.tutorialStep += 1
                    tutorialStep += 1
                }
            }
            .onChange(of: ProfileSetup.addedImage) {
                print("image added")
                ProfileSetup.tutorialStep += 1
                tutorialStep += 1
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    EditProfilePage(path: .constant(["Profile Page"]))
        .ignoresSafeArea(.keyboard)
}
