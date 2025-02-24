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
    
    var body: some View {
        PhotosPicker(selection: $selectedImage) {
            if (UserDefaults.standard.string(forKey:"image\(imageNumber)") != nil) {
                AsyncImage(url: URL(string: UserDefaults.standard.string(forKey:"image\(imageNumber)")!)) {result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                        .frame(width:CGFloat(sideLength),height:CGFloat(sideLength), alignment: .center)
                        .clipped()
                        .contentShape(Rectangle())
                        .clipShape(RoundedRectangle(cornerRadius:CGFloat(sideLength)*0.2))
                }
            }
            else
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width:CGFloat(sideLength),height:CGFloat(sideLength), alignment: .center)
                    .clipped()
                    .contentShape(Rectangle())
                    .clipShape(RoundedRectangle(cornerRadius:CGFloat(sideLength)*0.2))
            }
            else {
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
    }
    func loadImage() {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
           // uiImage = inputImage
            image = Image(uiImage: inputImage)
            do {
                let presignedResult: APIClient.PresignedPostUrlResponse = try await APIClient.getPresignedPostURL()
                let _: Void = try await APIClient.uploadImageToS3(
                    userId: UserDefaults.standard.string(forKey: "userId")!,
                    imageKey: "image\(imageNumber)",
                    image: inputImage,
                    presignedPostResult: presignedResult)
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
