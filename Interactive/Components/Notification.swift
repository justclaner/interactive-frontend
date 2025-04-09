//
//  Notification.swift
//  Interactive
//
//  Created by Justin Zou on 4/6/25.
//

import SwiftUI

struct Notification: View {
    @Binding var path: [String]
    @State var notificationId: String
    @State var profileImageUrl: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg"
    @State var username: String = "username"
    @State var message: String = "interacted with you"
    @State var isInteracting: Bool = false
    @State var action: String = "Interact"
    init(path: Binding<[String]>) {
        self._path = path
        self._notificationId = State(initialValue: (path.wrappedValue.last != nil && path.wrappedValue.last?.count ?? 0 > 13)
        ? String(path.wrappedValue.last!.dropFirst(13))
        : "")
    }
    
    let imageSquareWidth = Control.maxWidth * 0.22
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url:URL(string:profileImageUrl)) {phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(width: imageSquareWidth, height: imageSquareWidth)
                        .clipShape(
                            RoundedRectangle(cornerRadius: Control.tinyFontSize)
                        )
                } else {
                    RoundedRectangle(cornerRadius: Control.mediumFontSize)
                        .fill(Color.gray)
                        .frame(width: imageSquareWidth, height: imageSquareWidth)
                }
            }
            .padding([.leading])
            VStack {
                Spacer()
                Text(username)
                    .font(.system(size:Control.tinyFontSize, weight:.bold))
                    .fixedSize(horizontal: false, vertical: true)
                Text(message)
                    .font(.system(size:Control.tinyFontSize))
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .frame(maxWidth: Control.maxWidth * 0.35 , maxHeight: imageSquareWidth)
            .padding([.leading], -Control.tinyFontSize)
            Spacer()
            Button(action: {
                isInteracting.toggle()
            }) {
                Text(isInteracting ? "Interacting" : "Interact")
                    .font(.system(size: Control.tinyFontSize, weight: .semibold))
                    .foregroundStyle(Control.hexColor(hexCode: isInteracting ? "#000000" : "#FFDD1A"))
            }
            .frame(width:Control.maxWidth*0.35,height:Control.largeFontSize)
            .background(Control.hexColor(hexCode: isInteracting ? "#FFDD1A" :"#333333"))
            .clipShape(RoundedRectangle(cornerRadius: 0.5 * Control.tinyFontSize))
            .padding([.trailing])
        }
        .padding([.vertical])
        .frame(width: Control.maxWidth)
        .background(
            RoundedRectangle(cornerRadius: Control.mediumFontSize)
                .stroke(Control.hexColor(hexCode: "#9A9A9A"))
                .fill(Control.hexColor(hexCode: "#9A9A9A"))
        )
        .onTapGesture {
            print(notificationId)
        }
    }
}

#Preview {
    Notification(path: .constant(["notification-67f5da39528a58f2a31ebb16"]))
}
