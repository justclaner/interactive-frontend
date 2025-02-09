//
//  AboutYouPage.swift
//  Interactive
//
//  Created by Justin Zou on 11/10/24.
//

import SwiftUI

struct AboutYouPage: View {
    
    @Binding var path: [String]
    @State private var username: String = ""
    @State private var birthDay: Int = 0
    @State private var birthMonth: String = ""
    @State private var birthYear: Int = 0
    @State private var date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    @State private var isSelectingDate: Bool = false
    @FocusState private var usernameFocus: Bool
    /*
     The date range allowed for users to pick their birthday.
    */
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentDay = Calendar.current.component(.day, from: Date())
        let startRange = DateComponents(year: 1900, month: 1, day: 1)
        let endRange = DateComponents(year: currentYear - 18, month: currentMonth, day: currentDay)
        
        return calendar.date(from:startRange)!
            ...
            calendar.date(from:endRange)!
    }
    
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
                    if(isSelectingDate) {
                        isSelectingDate = false
                    }
                    usernameFocus = false
                }
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                LargeLogo()
                    .padding([.top],30)
                Text("Tell us something more about yourself")
                    .font(.system(size:31,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .padding([.top],40)
                    .padding([.bottom],10)
                    .frame(maxWidth:361,alignment:.leading)
//                HStack{
//                    Text("Are you a business?")
//                        .font(.system(size:16,weight:.semibold))
//                        .foregroundStyle(Control.hexColor(hexCode: "#FFDD1A"))
//                    
//                    Spacer()
//                    Button(action: {
//                        //add path
//                    }) {
//                        Text("I am a business")
//                            .font(.system(size:13,weight:.semibold))
//                            .foregroundStyle(Color.white)
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
//                    .frame(width:119,height:16)
//                    .padding(6)
//                    .background(Control.hexColor(hexCode: "#1A1A1A"))
//                    .clipShape(RoundedRectangle(cornerRadius:999))
//                }
//                .padding([.vertical],20)
                Text("How do you prefer to be called?")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                TextField("", text: $username, prompt: Text(verbatim: "Add username...")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundColor(Control.hexColor(hexCode: "#B3B3B3")))
                    .padding(16)
                    .frame(width:361,height:43)
                    .border(Color.black,width:1)
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundStyle(Color.white)
                    .padding([.bottom],30)
                    .focused($usernameFocus)
                Text("Birth Date")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                if (!isSelectingDate) {
                    Button(action: {
                        isSelectingDate.toggle()
                    }) {
                        Text(Control.dateToString(date: date, dateStyle: "long", timeStyle: "none", locale: "en-US"))
                            .font(.system(size:20,weight:.semibold))
                            .foregroundStyle(Control.hexColor(hexCode: "#1A1A1A"))
                            .padding(10)
                            .frame(maxWidth:.infinity,maxHeight:.infinity)
                    }
                    .frame(width:361,height:40)
                    .background(Color.white.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.6), lineWidth: 1)
                    )
                } else {
                    DatePicker(
                        "",
                        selection: $date,
                        in: dateRange,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                    .background(Color.white.opacity(0.05), in: RoundedRectangle(cornerRadius: 20))
                    .onChange(of: date, initial: false) {
                        let dateFormatter = DateFormatter()
                        
                        dateFormatter.dateFormat = "YYYY"
                        let year: String = dateFormatter.string(from: date)
                        birthYear = Int(year)!
                        
                        dateFormatter.dateFormat = "MM"
                        let month: String = dateFormatter.string(from: date)
                        birthMonth = month
                        
                        dateFormatter.dateFormat = "dd"
                        let day: String = dateFormatter.string(from: date)
                        birthDay = Int(day)!
                    }
                }
                
                Spacer()
                Button(action: {
                    
                    //do username check in database:
                    
                    
                    //store birthday info
                    UserDefaults.standard.set(birthDay, forKey: "birthDay")
                    UserDefaults.standard.set(birthMonth, forKey: "birthMonth")
                    UserDefaults.standard.set(birthYear, forKey: "birthYear")
                    path.append("Add Email")
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
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    AboutYouPage(path:.constant(["Login","About You"]))
}
