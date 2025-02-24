//
//  ProfilePage.swift
//  Interactive
//
//  Created by Justin Zou on 11/26/24.
//

import SwiftUI
import UIKit

struct EditProfilePage: View {
    
    @State var largeSideLength = 174.0
    @State var mediumSideLength = 81.0
    @State var smallSideLength = 50.0
    @State var visitors: Int = 0
    @State var interactions: Int = 0
    @State var aboutMe: String = UserDefaults.standard.string(forKey: "biography") ?? ""
    @State var add: String = "Add"
    @State var addInsight: String = "Add New Insight"
    @State var gray_80: String = "#CCCCCC"
    @State var accent: String = "#FFDD1A"
    @State var updater: Bool = false
    
    
    @State var username: String = UserDefaults.standard.string(forKey: "username") ?? "Username"
    
    @Binding var path: [String]
    @FocusState var aboutMeFocus: Bool
    @FocusState var usernameFocus: Bool
    
    @State var inTutorial: Bool = ProfileSetup.inTutorial
    @State var tutorialStep: Int = ProfileSetup.tutorialStep
    @State var addedImage: Bool = ProfileSetup.addedImage
    
    @State var networkLinks: [String] = []
    
    
    //image for display
    @State var image1: Image?
    @State var image2: Image?
    @State var image3: Image?
    @State var image4: Image?
    @State var image5: Image?
    
    
    var body: some View {
        //avoid keyboard pushing things up
        GeometryReader {geometry in
            ZStack {
                Text("\(updater)") //force rerender
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
                        print(UserDefaults.standard.string(forKey: "locationStatus") ?? "no status")
                     //   print(UserDefaults.standard.string(forKey:"userId") ?? "no id")
//                        print(UserDefaults.standard.bool(forKey: "inTutorial"))
//                        print("tutorialStep: \(tutorialStep)")
//                        print("ProfileSetup.tutorialStep: \(ProfileSetup.tutorialStep)")
//                        print(ProfileSetup.addedImage)
                        if (tutorialStep == 0) {
                            tutorialStep = 1
                            ProfileSetup.tutorialStep = 1
                        }
                        if (tutorialStep == 2) {
                            tutorialStep = 3
                            ProfileSetup.tutorialStep = 3
                        }
                        updater.toggle()
                    }
//                BackButton(path:$path)
//                    .padding([.top],20)
//                    .opacity(inTutorial ?
//                             ProfileSetup.tutorialWhiteOpacity : 1)
                
//username      //step 1
                HStack {
                    Spacer()
                    VStack {
                        Image("pencil_edit")
                            .resizable()
                            .frame(width:20,height:20)
                            .onTapGesture {
                                if (!(inTutorial && tutorialStep != 0)) {
                                    usernameFocus.toggle()
                                }
                            }
                            .opacity((inTutorial && tutorialStep != 0) ? ProfileSetup.tutorialWhiteOpacity : 1)
                            .padding([.top],20)
                        Spacer()
                    }
                    .padding([.trailing],geometry.size.width*0.05)
                    
                }
                VStack {
                    TextField("", text:$username,
                              prompt:Text(username)
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
                        self.username = String(username.prefix(24))
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .onChange(of: usernameFocus) {
                        if (username != UserDefaults.standard.string(forKey: "username")!) {
                            UserDefaults.standard.set(username, forKey: "username")
                        }
                    }
                    
                    
//images            //step 2
                    HStack {
                        AddImageIcon(image: $image1, imageNumber: .constant(1), sideLength:$largeSideLength)
                        HStack {
                            VStack {
                                AddImageIcon(image: $image2, imageNumber: .constant(2), sideLength:$mediumSideLength)
                                Spacer()
                                AddImageIcon(image: $image3, imageNumber: .constant(4), sideLength:$mediumSideLength)
                            }
                            .frame(maxHeight:174)
                            Spacer()
                            VStack {
                                AddImageIcon(image: $image4, imageNumber: .constant(3), sideLength:$mediumSideLength)
                                Spacer()
                                AddImageIcon(image: $image5, imageNumber: .constant(5), sideLength:$mediumSideLength)
                            }
                            .frame(maxHeight:174)
                        }.frame(width:174)
                        Spacer()
                    }
                    .padding([.top], 10)
                    .opacity((inTutorial && tutorialStep != 1) ?
                             ProfileSetup.tutorialWhiteOpacity : 1)
                    .onTapGesture {
                        updater.toggle()
                    }
                    .onAppear {
                        updater.toggle()
                    }
                    .allowsHitTesting(ProfileSetup.tutorialStep > 0 || !UserDefaults.standard.bool(forKey: "inTutorial"))
                    //step 3
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
                    .frame(maxWidth:geometry.size.width*0.9)
                    .padding([.vertical],10)
                    .opacity((inTutorial && tutorialStep != 2) ?
                             ProfileSetup.tutorialWhiteOpacity : 1)
                    
//biography         //step 4
                    VStack {
                        Text("About Me")
                            .font(.system(size:13,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                            .frame(width:geometry.size.width*0.9,alignment:.leading)

                        TextField("", text: $aboutMe, axis:.vertical)
                                .focused($aboutMeFocus)
                                .padding([.leading,.trailing],10)
                                .padding([.vertical],5)
                                .frame(width:geometry.size.width*0.9)
                                .font(.system(size:13,weight:.regular))
                                .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                                .background(Control.hexColor(hexCode: "#4D4D4D"))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding([.bottom],10)
                                .disabled(ProfileSetup.inTutorial && ProfileSetup.tutorialStep != 3)
                                .onChange(of: aboutMe) {
                                    aboutMe = String(aboutMe.prefix(150))
                                    
                                }
                                .lineLimit(3, reservesSpace: true)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                    }
                    .opacity((inTutorial && tutorialStep != 3) ?
                             ProfileSetup.tutorialWhiteOpacity : 1)
// network
                    VStack {
                        Text("Network")
                            .font(.system(size:13,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                            .frame(width:geometry.size.width*0.9,alignment:.leading)
                        HStack {
                            ScrollView(.horizontal) {
                                HStack {
                                    NetworkList()
                                    AddNetworkIcon(sideLength:$smallSideLength)
                                        .onTapGesture {
                                            path.append("Add Network")
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .opacity(inTutorial ? ProfileSetup.tutorialWhiteOpacity : 1)
                    //add in the future
//                    VStack {
//                        Text("Interests")
//                            .font(.system(size:13,weight:.semibold))
//                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
//                            .frame(width:geometry.size.width*0.9,alignment:.leading)
//                            .padding([.top],5)
//                        HStack {
//                            AddButton(action:$testFunc, text: $add, colorHex:$gray_80)
//                            Spacer()
//                        }
//                        Text("Jobs")
//                            .font(.system(size:13,weight:.semibold))
//                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
//                            .frame(width:geometry.size.width*0.9,alignment:.leading)
//                            .padding([.top],5)
//                        HStack {
//                            AddButton(action:$testFunc, text: $add, colorHex:$gray_80)
//                            Spacer()
//                        }
//                        Text("Interaction Goals")
//                            .font(.system(size:13,weight:.semibold))
//                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
//                            .frame(width:geometry.size.width*0.9,alignment:.leading)
//                            .padding([.top],5)
//                        HStack {
//                            AddButton(action:$testFunc, text: $add, colorHex:$gray_80)
//                            Spacer()
//                        }
//                        HStack {
//                            AddButton(action:$testFunc, text: $addInsight, colorHex:$accent)
//                            Spacer()
//                        }
//                        .padding([.top],10)
//                    }
//                    .opacity(ProfileSetup.tutorialWhiteOpacity)
                    Spacer()
                }
                .frame(maxWidth:geometry.size.width*0.9)
                NavigationBar(height:.constant(geometry.size.height*0.13))
                    //.opacity(ProfileSetup.tutorialWhiteOpacity)
                
                
                //step 1
                VStack {
                    Text("Tap your username or the pencil icon to edit your \nusername.")
                        .foregroundStyle(Color.white)
                        .font(.system(size:16,weight:.regular))
                    Spacer()
                }
                .frame(maxWidth:geometry.size.width*0.9,alignment:.leading)
                .opacity((tutorialStep == 0 && inTutorial) ? 1 : 0)
                .padding([.top],60)
                
                //step 2
                VStack {
                    Group {
                        Text("Insert at least one photo of yourself to continue.")
                            .foregroundStyle(Control.hexColor(hexCode: accent))
                        +
                        Text(" It is important that others recognize you!")
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                }
                .font(.system(size:16,weight:.regular))
                .frame(maxWidth:geometry.size.width*0.9,alignment:.leading)
                .opacity((tutorialStep == 1 && inTutorial) ? 1 : 0)
                .padding([.top],240)
                
                //step 3
                VStack {
                    Group {
                        Text("You will be able to see how many people have ")
                            .foregroundStyle(Color.white)
                            .bold()
                        +
                        Text("visited ")
                            .foregroundStyle(Control.hexColor(hexCode: accent))
                        +
                        Text("your profile and how many people you have ")
                            .foregroundStyle(Color.white)
                        +
                        Text("interacted ")
                            .foregroundStyle(Control.hexColor(hexCode: accent))
                        +
                        Text("with.")
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                }
                .font(.system(size:16,weight:.regular))
                .frame(maxWidth:geometry.size.width*0.9,alignment:.leading)
                .opacity((tutorialStep == 2 && inTutorial) ? 1 : 0)
                .padding([.top],305)
                
                
                //step 4
                VStack {
                    Group {
                        Text("Tell something more ")
                            .foregroundStyle(Control.hexColor(hexCode: accent))
                            .bold()
                        +
                        Text("about yourself ")
                            .foregroundStyle(Control.hexColor(hexCode: accent))
                        +
                        Text("to people who would like to connect.")
                            .foregroundStyle(Color.white)
                    }
                        .font(.system(size:16,weight:.regular))
//                    Text("Skip for now")
//                        .font(.system(size:13,weight:.semibold))
//                        .foregroundStyle(Control.hexColor(hexCode: accent))
//                        .frame(maxWidth:geometry.size.width*0.835,alignment:.leading)
//                        .underline()
//                        .onTapGesture {
//                            ProfileSetup.addedBio = true
//                        }
                    Spacer()
                }
                .frame(maxWidth:geometry.size.width*0.9,alignment:.leading)
                .opacity(tutorialStep == 3 ? 1 : 0)
                .padding([.top],390)
            }
            .onChange(of: ProfileSetup.addedImage) { //step 2 add image
                print("image added")
                ProfileSetup.tutorialStep = 2
                tutorialStep = 2
            }
            .onChange(of: aboutMeFocus) {  //step 3 visitors/interactions
                if (ProfileSetup.addedBio && ProfileSetup.tutorialStep == 3) {
                    ProfileSetup.tutorialStep = 4
                    tutorialStep = 4
                }
                if (!aboutMeFocus && aboutMe != UserDefaults.standard.string(forKey: "biography") ?? "") {
                    Task {
                        do {
                            let updateBioReq = try await APIClient.updateBio(bio: aboutMe)
                            if (updateBioReq.success) {
                                UserDefaults.standard.set(aboutMe, forKey: "biography")
                                ProfileSetup.addedBio = true
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .onChange(of: ProfileSetup.tutorialStep) { //step 4 about me
                if (ProfileSetup.tutorialStep >= ProfileSetup.lastStep) {
                    ProfileSetup.inTutorial = false
                    inTutorial = false
                    UserDefaults.standard.set(false, forKey:"inTutorial")
                    UserDefaults.standard.set(username, forKey: "username")
                    UserDefaults.standard.set(aboutMe, forKey:"biography")
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    
}




#Preview {
    EditProfilePage(path: .constant(["Profile Page"]))
        .ignoresSafeArea(.keyboard)
}
