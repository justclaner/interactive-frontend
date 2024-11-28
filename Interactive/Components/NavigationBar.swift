//
//  NavigationBar.swift
//  Interactive
//
//  Created by Justin Zou on 11/26/24.
//

import SwiftUI

struct NavigationBar: View {
    var iconSideLength: CGFloat = 40
    @Binding var height: CGFloat
    @State var activePresence: Bool = false
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Control.hexColor(hexCode: "#1A1A1A").opacity(0.65))
                    .frame(maxWidth:.infinity,maxHeight:height)
                    .ignoresSafeArea()
                HStack {
                    Image(systemName:"house")
                        .font(.system(size:iconSideLength))
                        .frame(maxWidth:.infinity)
                    Image(systemName:"person.2")
                        .font(.system(size:iconSideLength))
                        .frame(maxWidth:.infinity)
                    VStack{
                        Ellipse()
                            .fill(Control.hexColor(hexCode: activePresence ? "#FFDD1A" : "#999999"))
                            .frame(width:10,height:9)
                            .padding([.bottom],-4)
                            .padding([.top],7)
                        Rectangle()
                            .fill(Control.hexColor(hexCode: activePresence ? "#FFDD1A" : "#999999"))
                            .frame(width:10,height:33)
                            .clipShape(RoundedRectangle(cornerRadius:12.11))
                            .padding([.bottom],10)
                    }
                        .background(
                            Circle()
                                .fill(Control.hexColor(hexCode:"#333333"))
                                .frame(width:70,height:70)
                        )
                        .frame(maxWidth:.infinity)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration:0.25)) {
                                activePresence.toggle()
                            }
                        }
                        .transition(.opacity)
                    Image(systemName:"bell")
                        .font(.system(size:iconSideLength))
                        .frame(maxWidth:.infinity)
                    Image(systemName:"person")
                        .font(.system(size:iconSideLength))
                        .frame(maxWidth:.infinity)
                }
                .padding()
                .frame(maxWidth:.infinity,maxHeight:height)
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationBar(height: .constant(CGFloat(120)))
}
