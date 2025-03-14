//
//  ProfileCard.swift
//  Interactive
//
//  Created by Justin Zou on 3/11/25.
//

import SwiftUI

struct ProfileCard: View {
    
    @Binding var path: [String]
    @State var test: String
    
    init(path: Binding<[String]>) {
        self._test = State(initialValue: "fuck")
        self._path = path
    }
    
    let imageSquareWidth = Control.maxWidth * 0.42
    let cardWidth = Control.maxWidth * 0.5
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url:URL(string: "https://media.istockphoto.com/id/1419410282/photo/silent-forest-in-spring-with-beautiful-bright-sun-rays.jpg?s=612x612&w=0&k=20&c=UHeb1pGOw6ozr6utsenXHhV19vW6oiPIxDqhKCS2Llk=")) {result in
                result.image?
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSquareWidth, height: imageSquareWidth)
                    .clipShape(
                        RoundedRectangle(cornerRadius: Control.mediumFontSize)
                    )
            }
            .padding([.top], (cardWidth - imageSquareWidth) / 2)
            .border(Color.blue, width: 2)
            Text("Name")
                .font(.system(size: Control.mediumFontSize, weight: .bold))
                .frame(width: imageSquareWidth, alignment: .leading)
                .border(Color.blue, width: 2)
                .padding(0)
        }
        .frame(width: cardWidth)
        .border(Color.red, width: 2)
        .background(
            RoundedRectangle(cornerRadius: Control.mediumFontSize)
                .stroke(Control.hexColor(hexCode: "#9A9A9A"))
                .fill(Control.hexColor(hexCode: "#9A9A9A"))
        )
        .onTapGesture {
            //test
            print(test)
        }
    }
}

#Preview {
    ProfileCard(path: .constant(["help"]))
}
