//
//  ProfilePage.swift
//  Interactive
//
//  Created by Justin Zou on 11/26/24.
//

import SwiftUI
import PhotosUI
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
    
    @State var showPhotosPicker: Bool = false
    
    @State var selectedImage: PhotosPickerItem?
    
    @State var username: String = UserDefaults.standard.string(forKey: "username") ?? "Username"
    
    @Binding var path: [String]
    @FocusState var aboutMeFocus: Bool
    @FocusState var usernameFocus: Bool
    
    //ProfileSetup.inTutorial
    @State var inTutorial: Bool = UserDefaults.standard.bool(forKey: "inTutorial")
    @State var tutorialStep: Int = 0
    @State var addedImage: Bool = false
    
    @AppStorage("addedLink") var addedLink: Bool = UserDefaults.standard.bool(forKey: "addedLink")
    
    @AppStorage("image1") var image1URL: String = UserDefaults.standard.string(forKey: "image1") ?? ""
    @AppStorage("image2") var image2URL: String = UserDefaults.standard.string(forKey: "image2") ?? ""
    @AppStorage("image3") var image3URL: String = UserDefaults.standard.string(forKey: "image3") ?? ""
    @AppStorage("image4") var image4URL: String = UserDefaults.standard.string(forKey: "image4") ?? ""
    @AppStorage("image5") var image5URL: String = UserDefaults.standard.string(forKey: "image5") ?? ""
    
    @AppStorage("image1Loading") var image1Loading: Bool = UserDefaults.standard.bool(forKey: "image1Loading")
    @AppStorage("image2Loading") var image2Loading: Bool = UserDefaults.standard.bool(forKey: "image2Loading")
    @AppStorage("image3Loading") var image3Loading: Bool = UserDefaults.standard.bool(forKey: "image3Loading")
    @AppStorage("image4Loading") var image4Loading: Bool = UserDefaults.standard.bool(forKey: "image4Loading")
    @AppStorage("image5Loading") var image5Loading: Bool = UserDefaults.standard.bool(forKey: "image5Loading")
    
    @State var image1Clicked: Bool = false
    @State var image2Clicked: Bool = false
    @State var image3Clicked: Bool = false
    @State var image4Clicked: Bool = false
    @State var image5Clicked: Bool = false
    
    @State var changingPicture: Bool = false
    @State var currentImageNumber: Int = 1
    
    let xIconSize = Control.getScreenSize().width * 0.06
    let xIconCircleWidth = Control.getScreenSize().width * 0.08
    
    var data = UserData()
    
    var body: some View {
        //avoid keyboard pushing things up
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
                        showPhotosPicker = false
                   //     print(currentImageNumber)
//                        print(UserDefaults.standard.string(forKey: "locationStatus") ?? "no status")
                     //   print(UserDefaults.standard.string(forKey:"userId") ?? "no id")
//                        print(UserDefaults.standard.bool(forKey: "inTutorial"))
//                        print("tutorialStep: \(tutorialStep)")
//                        print("ProfileSetup.tutorialStep: \(ProfileSetup.tutorialStep)")
//                        print(ProfileSetup.addedImage)

                        updater.toggle()
                    }
//                BackButton(path:$path)
//                    .padding([.top],20)
//                    .opacity(inTutorial ?
//                             ProfileSetup.tutorialWhiteOpacity : 1)
                
//username      //step 1
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
                    .opacity((inTutorial) ? ProfileSetup.tutorialWhiteOpacity : 1)
                    .disabled(inTutorial)
                    .onChange(of: username) {
                        self.username = String(username.prefix(24))
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding([.bottom], Control.smallFontSize)
  //revised step 2
                    HStack {
                        ZStack {
                            ProfileImage(url: $image1URL, sideLength: $largeSideLength, imageNumber: .constant(1))
                                .padding([.trailing],mediumSideLength*0.1)
                                .onTapGesture {
                                    if (image1URL == "") {
                                        showPhotosPicker = true
                                    }
                                }
                            HStack {
                                Spacer()
                                VStack {
                                    Image("x-icon")
                                        .resizable()
                                        .frame(width:xIconSize, height:xIconSize)
                                        .background(
                                            Circle()
                                                .fill(Color.white)
                                                .opacity(0.5)
                                                .frame(width: xIconCircleWidth, height: xIconCircleWidth)
                                        )
                                        .onTapGesture {
                                            image1Clicked = true
                                        }
                                        .confirmationDialog("editImage1", isPresented: $image1Clicked) {
                                            Button("Delete") {
                                                deleteImage(imageNumber: 1)
                                            }
                                            Button("Change picture (1)") {
                                                currentImageNumber = 1
                                                changingPicture = true
                                                showPhotosPicker = true
                                            }
                                        }
                                    Spacer()
                                }
                            }
                        }.opacity(image1Loading ? 0.3 : 1)
                        HStack {
                            VStack {
                                ZStack {
                                    ProfileImage(url: $image2URL, sideLength: $mediumSideLength, imageNumber: .constant(2))
                                        .onTapGesture {
                                            if (image2URL == "") {
                                                showPhotosPicker = true
                                            }
                                        }
                                    HStack {
                                        Spacer()
                                        VStack {
                                            if (image2URL != "") {
                                                Image("x-icon")
                                                    .resizable()
                                                    .frame(width:xIconSize, height:xIconSize)
                                                    .background(
                                                        Circle()
                                                            .fill(Color.white)
                                                            .opacity(0.5)
                                                            .frame(width: xIconCircleWidth, height: xIconCircleWidth)
                                                    )
                                                    .onTapGesture {
                                                        image2Clicked = true
                                                    }
                                                    .confirmationDialog("editImage2", isPresented: $image2Clicked) {
                                                        Button("Delete") {
                                                            deleteImage(imageNumber: 2)
                                                        }
                                                        Button("Change picture (2)") {
                                                            currentImageNumber = 2
                                                            changingPicture = true
                                                            showPhotosPicker = true
                                                        }
                                                    }
                                            }
                                            Spacer()
                                        }
                                    }
                                }.opacity(image2Loading ? 0.3 : 1)
                                Spacer()
                                ZStack {
                                    ProfileImage(url: $image4URL, sideLength: $mediumSideLength, imageNumber: .constant(4))
                                        .onTapGesture {
                                            if (image4URL == "") {
                                                showPhotosPicker = true
                                            }
                                        }
                                    HStack {
                                        Spacer()
                                        VStack {
                                            if (image4URL != "") {
                                                Image("x-icon")
                                                    .resizable()
                                                    .frame(width:xIconSize, height:xIconSize)
                                                    .background(
                                                        Circle()
                                                            .fill(Color.white)
                                                            .opacity(0.5)
                                                            .frame(width: xIconCircleWidth, height: xIconCircleWidth)
                                                    )
                                                    .onTapGesture {
                                                        image4Clicked = true
                                                    }
                                                    .confirmationDialog("editImage4", isPresented: $image4Clicked) {
                                                        Button("Delete") {
                                                            deleteImage(imageNumber: 4)
                                                        }
                                                        Button("Change picture (4)") {
                                                            currentImageNumber = 4
                                                            changingPicture = true
                                                            showPhotosPicker = true
                                                        }
                                                    }
                                            }
                                            Spacer()
                                        }
                                    }
                                }.opacity(image4Loading ? 0.3 : 1)
                            }
                            .frame(maxHeight:largeSideLength)
                            Spacer()
                            VStack {
                                ZStack {
                                    ProfileImage(url: $image3URL, sideLength: $mediumSideLength, imageNumber: .constant(3))
                                        .onTapGesture {
                                            if (image3URL == "") {
                                                showPhotosPicker = true
                                            }
                                        }
                                    HStack {
                                        Spacer()
                                        VStack {
                                            if (image3URL != "") {
                                                Image("x-icon")
                                                    .resizable()
                                                    .frame(width:xIconSize, height:xIconSize)
                                                    .background(
                                                        Circle()
                                                            .fill(Color.white)
                                                            .opacity(0.5)
                                                            .frame(width: xIconCircleWidth, height: xIconCircleWidth)
                                                    )
                                                    .onTapGesture {
                                                        image3Clicked = true
                                                    }
                                                    .confirmationDialog("editImage3", isPresented: $image3Clicked) {
                                                        Button("Delete") {
                                                            deleteImage(imageNumber: 3)
                                                        }
                                                        Button("Change picture (3)") {
                                                            currentImageNumber = 3
                                                            changingPicture = true
                                                            showPhotosPicker = true
                                                        }
                                                    }
                                            }
                                            Spacer()
                                        }
                                    }
                                }.opacity(image3Loading ? 0.3 : 1)
                                Spacer()
                                ZStack {
                                    ProfileImage(url: $image5URL, sideLength: $mediumSideLength, imageNumber: .constant(5))
                                        .onTapGesture {
                                            if (image5URL == "") {
                                                showPhotosPicker = true
                                            }
                                        }
                                    HStack {
                                        Spacer()
                                        VStack {
                                            if (image5URL != "") {
                                                Image("x-icon")
                                                    .resizable()
                                                    .frame(width:xIconSize, height:xIconSize)
                                                    .background(
                                                        Circle()
                                                            .fill(Color.white)
                                                            .opacity(0.5)
                                                            .frame(width: xIconCircleWidth, height: xIconCircleWidth)
                                                    )
                                                    .onTapGesture {
                                                        image5Clicked = true
                                                    }
                                                    .confirmationDialog("editImage5", isPresented: $image5Clicked) {
                                                        Button("Delete") {
                                                            deleteImage(imageNumber: 5)
                                                        }
                                                        Button("Change picture (5)") {
                                                            currentImageNumber = 5
                                                            changingPicture = true
                                                            showPhotosPicker = true
                                                        }
                                                    }
                                            }
                                            Spacer()
                                        }
                                    }
                                }.opacity(image5Loading ? 0.3 : 1)
                            }
                            .frame(maxHeight: largeSideLength)
                        }.frame(width: largeSideLength)
                        Spacer()
                    }
                    .frame(maxHeight: largeSideLength)
                    .photosPicker(isPresented: $showPhotosPicker, selection: $selectedImage)
                    .onChange(of: selectedImage) {
                        print(image1Clicked)
                        if (!changingPicture) {
                            if (image1URL == "") {
                                currentImageNumber = 1
                            } else if (image2URL == "") {
                                currentImageNumber = 2
                            } else if (image3URL == "") {
                                currentImageNumber = 3
                            } else if (image4URL == "") {
                                currentImageNumber = 4
                            } else if (image5URL == "") {
                                currentImageNumber = 5
                            }
                        }
                        loadImage(imageNumber: currentImageNumber)
                        
                        changingPicture = false
                    }
//images            //step 2
//                    HStack {
////                        if (image1URL != "") {
////                            AsyncImage(url: URL(string: UserDefaults.standard.string(forKey:"image1")!)) {result in
////                                result.image?
////                                    .resizable()
////                                    .scaledToFill()
////                                    .frame(width:CGFloat(largeSideLength),height:CGFloat(largeSideLength), alignment: .center)
////                                    .clipped()
////                                    .contentShape(Rectangle())
////                                    .clipShape(RoundedRectangle(cornerRadius:CGFloat(largeSideLength)*0.2))
////                            }
////                        } else {
//                            AddImageIcon(image: $image1, imageNumber: .constant(1), sideLength:$largeSideLength)
//                     //   }
//                        HStack {
//                            VStack {
//                                AddImageIcon(image: $image2, imageNumber: .constant(2), sideLength:$mediumSideLength)
//                                Spacer()
//                                AddImageIcon(image: $image3, imageNumber: .constant(4), sideLength:$mediumSideLength)
//                            }
//                            .frame(maxHeight:174)
//                            Spacer()
//                            VStack {
//                                AddImageIcon(image: $image4, imageNumber: .constant(3), sideLength:$mediumSideLength)
//                                Spacer()
//                                AddImageIcon(image: $image5, imageNumber: .constant(5), sideLength:$mediumSideLength)
//                            }
//                            .frame(maxHeight:174)
//                        }.frame(width:174)
//                        Spacer()
//                    }
//                    .padding([.top], 10)
//                    .opacity((inTutorial && tutorialStep != 1) ?
//                             ProfileSetup.tutorialWhiteOpacity : 1)
//                    .onTapGesture {
//                        updater.toggle()
//                    }
//                    .onAppear {
//                        updater.toggle()
//                    }
//                    .allowsHitTesting(ProfileSetup.tutorialStep > 0 || !UserDefaults.standard.bool(forKey: "inTutorial"))
                    
                    
                    
                    
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
                    .frame(maxWidth:Control.maxWidth)
                    .padding([.vertical],10)
                    .opacity((inTutorial) ?
                             ProfileSetup.tutorialWhiteOpacity : 1)
                    
//biography         //step 4
                    VStack {
                        Text("About Me")
                            .font(.system(size:Control.tinyFontSize,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                            .frame(width:Control.maxWidth,alignment:.leading)

                        TextField("", text: $aboutMe, axis:.vertical)
                                .focused($aboutMeFocus)
                                .padding([.leading,.trailing],10)
                                .padding([.vertical],5)
                                .frame(width:Control.maxWidth)
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
                    .opacity(inTutorial ?
                             ProfileSetup.tutorialWhiteOpacity : 1)
// network
                    VStack {
                        Text("Network")
                            .font(.system(size:Control.tinyFontSize,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
                            .frame(width:Control.maxWidth,alignment:.leading)
                        HStack {
                            ScrollView(.horizontal) {
                                HStack {
                                    EditProfileNetworks(path: $path)
                                    AddNetworkIcon(sideLength:$smallSideLength)
                                        .onTapGesture {
                                            print("test")
                                            path.append("Add Network")
                                        }
                                    Spacer()
                                }.frame(maxHeight: Control.getScreenSize().width * 0.2)
                            }
                        }
                    }
                    .opacity((inTutorial && tutorialStep != 1) ? ProfileSetup.tutorialWhiteOpacity : 1)
                    //add in the future
//                    VStack {
//                        Text("Interests")
//                            .font(.system(size:13,weight:.semibold))
//                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
//                            .frame(width:Control.maxWidth,alignment:.leading)
//                            .padding([.top],5)
//                        HStack {
//                            AddButton(action:$testFunc, text: $add, colorHex:$gray_80)
//                            Spacer()
//                        }
//                        Text("Jobs")
//                            .font(.system(size:13,weight:.semibold))
//                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
//                            .frame(width:Control.maxWidth,alignment:.leading)
//                            .padding([.top],5)
//                        HStack {
//                            AddButton(action:$testFunc, text: $add, colorHex:$gray_80)
//                            Spacer()
//                        }
//                        Text("Interaction Goals")
//                            .font(.system(size:13,weight:.semibold))
//                            .foregroundStyle(Control.hexColor(hexCode: "#999999"))
//                            .frame(width:Control.maxWidth,alignment:.leading)
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
                .frame(maxWidth:Control.maxWidth)
                NavigationBar()
                
                //settings gear icon
                HStack {
                    Spacer()
                    VStack {
                        Image("settings_gear")
                            .resizable()
                            .frame(width:35,height:35)
                            .onTapGesture {
                                print("settings page")
                                path.append("Settings")
                            }
                            .opacity((inTutorial && tutorialStep != 0) ? ProfileSetup.tutorialWhiteOpacity : 1)
                            .padding([.trailing],Control.smallFontSize * 0.8)
                            .padding([.top], Control.smallFontSize * 0.7)
                            
                        Spacer()
                    }
                }
                
                    //.opacity(ProfileSetup.tutorialWhiteOpacity)
                
                
                //step 1
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
                .frame(maxWidth:Control.maxWidth,alignment:.leading)
                .opacity((tutorialStep == 0 && inTutorial) ? 1 : 0)
                .padding([.top],Control.largeFontSize * 7.5)
                
                //step 2
                VStack {
                    Group {
                        Text("Connect your social networks to interact with others. ")
                            .foregroundStyle(Control.hexColor(hexCode: accent))
                            .bold()
 //                       +
//                        Text("You will be able to decide whether .")
//                            .foregroundStyle(Color.white)
                    }
                    .font(.system(size:Control.tinyFontSize,weight:.regular))
                    Spacer()
                }
                .frame(maxWidth:Control.maxWidth,alignment:.leading)
                .opacity(inTutorial && tutorialStep == 1 ? 1 : 0)
                .padding([.top],Control.largeFontSize * 13.75)
            }
            .onChange(of: addedImage) { //step 2 add image
                print("image added")
                tutorialStep += 1
            }
            .onChange(of: addedLink) {
                print("link added")
                tutorialStep += 1
            }
            .onChange(of: usernameFocus) {
                if (!usernameFocus && username != UserDefaults.standard.string(forKey: "username") ?? "") {
                    Task {
                        do {
                            let updateUsernameReq = try await APIClient.updateUsername(username: username)
                            print(updateUsernameReq)
                            if (updateUsernameReq.success) {
                                UserDefaults.standard.set(username, forKey: "username")
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .onChange(of: aboutMeFocus) {
                if (!aboutMeFocus && aboutMe != UserDefaults.standard.string(forKey: "biography") ?? "") {
                    Task {
                        do {
                            let updateBioReq = try await APIClient.updateBio(bio: aboutMe)
                            if (updateBioReq.success) {
                                UserDefaults.standard.set(aboutMe, forKey: "biography")
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .onChange(of: tutorialStep) { //step 4 about me
                if (tutorialStep > ProfileSetup.lastStep) {
                    ProfileSetup.inTutorial = false
                    inTutorial = false
                    UserDefaults.standard.set(false, forKey:"inTutorial")
                }
            }
        .ignoresSafeArea(.keyboard)
    }
    
    func loadImage(imageNumber: Int) {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            do {
                let presignedResult: APIClient.PresignedPostUrlResponse = try await APIClient.getPresignedPostURL()
                let _: Void = try await APIClient.uploadImageToS3(
                    userId: UserDefaults.standard.string(forKey: "userId")!,
                    imageIndex: "image\(imageNumber)",
                    image: inputImage,
                    presignedPostResult: presignedResult)
            } catch {
                print(error)
            }
        }
        if (inTutorial) {
            addedImage = true
        }
    }
    
    func deleteImage(imageNumber: Int) {
        var url: String = ""
        var imageKey: String = ""
        switch imageNumber {
        case 1:
            url = image1URL
            imageKey = "image1"
        case 2:
            url = image2URL
            imageKey = "image2"
        case 3:
            url = image3URL
            imageKey = "image3"
        case 4:
            url = image4URL
            imageKey = "image4"
        default:
            url = image5URL
            imageKey = "image5"
        }
        Task {
            do {
                let deleteResponse = try await APIClient.deleteUserImage(imageURL:  url, imageIndex: imageKey, userId: UserDefaults.standard.string(forKey: "userId") ?? "")
                print(deleteResponse)
                if (deleteResponse.success) {
                    data.loadImages(userId: UserDefaults.standard.string(forKey: "userId") ?? "");
                }
            } catch {
                print(error)
            }
        }
    }
    
}




#Preview {
    EditProfilePage(path: .constant(["Profile Page"]))
        .ignoresSafeArea(.keyboard)
}
