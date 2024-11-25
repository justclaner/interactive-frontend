//
//  VerifyPhone.swift
//  Interactive
//
//  Created by Justin Zou on 11/24/24.
//

import SwiftUI

struct VerifyPhonePage: View {
    @Binding var path: [String]
    //TO-DO: get sms from global variables in Helper
    @State var sms: String = "+39 1234567890"
    @State var inputField = [String](repeating: " ", count: Control.phoneVerificationCodeLength)
    @State var inputIndex: Int = 0
    @FocusState var inputFocus: Bool
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.001)
                .ignoresSafeArea()
                .background(
                    Image("Background1")
                        .resizable()
                        .ignoresSafeArea()
                )
                .onTapGesture(count:1) {
                    inputFocus = false
                }
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                LargeLogo()
                    .padding([.vertical],30)
                Text("Verify your number")
                    .font(.system(size:31,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.center)
                Text("We have sent you a code by SMS to the number \(sms)")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                    .frame(maxWidth:361,alignment: .leading)
                    .padding([.vertical],20)
                Text("My code is")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                HStack {
                    ForEach($inputField, id: \.self) {pointer in
                        NumberVerificationInputField(inputPointer: pointer)
                    }
                    Spacer()
                }
                .frame(width:361,height:51)
                .contentShape(Rectangle())
                .focusable()
                .focused($inputFocus)
                .onTapGesture(count:1) {
                    inputFocus = true
                }
                .onKeyPress(keys: [.delete]) { key in
                    if (inputIndex > 0) {
                        inputIndex -= 1
                        inputField[inputIndex] = " "
                    }
                    return .handled
                }
                .onKeyPress(characters: .decimalDigits) { key in
                    if (inputIndex < Control.phoneVerificationCodeLength) {
                        inputField[inputIndex] = key.characters
                        inputIndex += 1
                    }
                    return .handled
                }
                HStack {
                    Text("Resend Code")
                        .font(.system(size:16,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                        .underline()
                        .onTapGesture() {
                            //resend code
                        }
                    Text("-")
                        .font(.system(size:16,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                    Text("Change Number")
                        .font(.system(size:16,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                        .underline()
                        .onTapGesture() {
                            path.removeLast()
                        }
                    Spacer()
                }
                .padding([.top],20)
                Spacer()
                Button(action: {
                    //append path
                }) {
                    Text("Continue")
                        .font(.system(size:17,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:361,height:40)
                .background(Control.hexColor(hexCode: "#FFDD1A"))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
            }
            .frame(maxWidth:361)
        }
    }
}

#Preview {
    VerifyPhonePage(path: .constant(["Verify Phone"]))
}
