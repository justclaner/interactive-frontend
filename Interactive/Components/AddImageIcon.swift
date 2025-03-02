//
//  AddImage.swift
//  Interactive
//
//  Created by Justin Zou on 11/26/24.
//

import SwiftUI
import PhotosUI

struct AddImageIcon: View {
    @State var selectedImage: PhotosPickerItem?
   
    
    @Binding var image: Image?
    
   // @Binding var uiImage: UIImage?
    @Binding var imageNumber: Int
    @Binding var sideLength: Double
    
    
    //to-do: find a better way to implement this
    @AppStorage("image1") var image1: String = UserDefaults.standard.string(forKey: "image1") ?? ""
    @AppStorage("image2") var image2: String = UserDefaults.standard.string(forKey: "image2") ?? ""
    @AppStorage("image3") var image3: String = UserDefaults.standard.string(forKey: "image3") ?? ""
    @AppStorage("image4") var image4: String = UserDefaults.standard.string(forKey: "image4") ?? ""
    @AppStorage("image5") var image5: String = UserDefaults.standard.string(forKey: "image5") ?? ""
    
    @State var showTemporaryImage: Bool = false
    var body: some View {
        ZStack {
            PhotosPicker(selection: $selectedImage) {
                if (imageNumber == 1 && image1 != "") {
                    ProfileImage(url: $image1, sideLength: $sideLength, imageNumber: .constant(1))
                } else if (imageNumber == 2 && image2 != "") {
                    ProfileImage(url: $image2, sideLength: $sideLength, imageNumber: .constant(2))
                } else if (imageNumber == 3 && image3 != "") {
                    ProfileImage(url: $image3, sideLength: $sideLength, imageNumber: .constant(3))
                } else if (imageNumber == 4 && image4 != "") {
                    ProfileImage(url: $image4, sideLength: $sideLength, imageNumber: .constant(4))
                } else if (imageNumber == 5 && image5 != "") {
                    ProfileImage(url: $image5, sideLength: $sideLength, imageNumber: .constant(5))
                }
                else
                {
                    ZStack {
                        RoundedRectangle(cornerRadius:CGFloat(sideLength)*0.2)
                            .fill(Control.hexColor(hexCode:"#999999"))
                            .frame(width:CGFloat(sideLength),height:CGFloat(sideLength))
                        Image(systemName:"plus")
                            .font(.system(size:sideLength*0.5))
                            .foregroundStyle(Control.hexColor(hexCode:"#CCCCCC"))
                    }
                }
            }
            .onChange(of: selectedImage) {
                loadImage()
            }
            //overlay temporary image while real image is being uploaded
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width:CGFloat(sideLength),height:CGFloat(sideLength), alignment: .center)
                    .clipped()
                    .contentShape(Rectangle())
                    .clipShape(RoundedRectangle(cornerRadius:CGFloat(sideLength)*0.2))
                    .opacity(showTemporaryImage ? 1 : 0)
            }
        }
    }
    func loadImage() {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            image = Image(uiImage: inputImage)
            showTemporaryImage = true;
            do {
                let presignedResult: APIClient.PresignedPostUrlResponse = try await APIClient.getPresignedPostURL()
                let _: Void = try await APIClient.uploadImageToS3(
                    userId: UserDefaults.standard.string(forKey: "userId")!,
                    imageIndex: "image\(imageNumber)",
                    image: inputImage,
                    presignedPostResult: presignedResult)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Control.showTemporaryImageInterval) {
                    showTemporaryImage = false
                }
            } catch {
                print(error)
            }
        }
        ProfileSetup.addedImage = true
        print("Image Number: \(imageNumber)")
    }
    
    func getImage() -> (Int,Image?) {
        return (imageNumber,image)
    }
}

#Preview {
    AddImageIcon(image: .constant(nil), imageNumber: .constant(1), sideLength: .constant(100))
}
