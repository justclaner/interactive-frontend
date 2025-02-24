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
    
    @State var rawInput = ""
    
    let maxWidth = Control.getMaxWidth()
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
                    .frame(maxWidth:maxWidth,alignment:.center)
                Text("We have sent you a code by SMS to the number \(sms)")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Control.hexColor(hexCode: "#CCCCCC"))
                    .frame(maxWidth:maxWidth,alignment: .leading)
                    .padding([.vertical],20)
                Text("My code is")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:maxWidth,alignment:.leading)
                ZStack {
                    HStack {
                        ForEach($inputField, id: \.self) {pointer in
                            NumberVerificationInputField(inputPointer: pointer)
                        }
                        Spacer()
                    }
                    TextField("", text:$rawInput)
                        .focused($inputFocus)
                        .keyboardType(.decimalPad)
                        .foregroundStyle(Color.clear)
                        .tint(.clear)
                        .frame(width:maxWidth,height:51)
                        .onChange(of: rawInput) {
                            self.rawInput = String(rawInput.prefix(Control.phoneVerificationCodeLength))
                            inputField = displayCode(codeString: rawInput)
                            }
                }
                .frame(width:maxWidth,height:51)
                .contentShape(Rectangle())
                .onTapGesture {
                    inputFocus = true
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
                    
                }) {
                    Text("Continue")
                        .font(.system(size:17,weight:.semibold))
                        .foregroundStyle(Control.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:maxWidth,height:40)
                .background(Control.hexColor(hexCode: "#FFDD1A"))
                .clipShape(RoundedRectangle(cornerRadius:20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.6), lineWidth: 1)
                )
            }
            .frame(maxWidth:maxWidth)
        }
        .ignoresSafeArea(.keyboard)
    }
}

func displayCode(codeString: String) -> [String] {
    var newArr: [String] = []
    for char in codeString {
        newArr.append(String(char))
    }
    while (newArr.count < Control.phoneVerificationCodeLength) {
        newArr.append(" ")
    }
    return newArr
}

#Preview {
    VerifyPhonePage(path: .constant(["Verify Phone"]))
}
