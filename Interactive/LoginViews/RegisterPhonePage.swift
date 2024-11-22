//
//  RegisterPhone.swift
//  Interactive
//
//  Created by Justin Zou on 11/17/24.
//

import SwiftUI
import Combine

struct RegisterPhonePage: View {
    @Binding var path: [String]
    
    // (Helper.countryCode[String(describing: country)] ?? -1) gets the corresponding country code
    @State var country: Country = .US
    
    // Parse string to get first 10 numbers only
    @State var phoneNum: String = ""
    enum Country: String, CaseIterable, Identifiable {
        case US = "+1 (US/CA)"    //United States and Canada
        case EG = "+20 (EG)"   //Egypt
        case SS = "+211 (SS)"  //South Sudan
        case MA = "+212 (MA)"  //Morocco
        case DZ = "+213 (DZ)"  //Algeria
        case TN = "+216 (TN)"  //Tunisia
        case LY = "+218 (LY)"  //Libya
        case GH = "+233 (GH)"  //Ghana
        case GL = "+299 (GL)"  //Greenland
        case NL = "+31 (NL)"   //Netherlands
        case BE = "+32 (BE)"   //Belgium
        case FR = "+33 (FR)"   //France
        case ES = "+34 (ES)"   //Spain
        case PT = "+351 (PT)"  //Portugal
        case LU = "+352 (LU)"  //Luxembourg
        case IE = "+353 (IE)"  //Ireland
        case IS = "+354 (IS)"  //Iceland
        case AL = "+355 (AL)"  //Albania
        case FI = "+358 (FI)"  //Finland
        case IT = "+39 (IT)"   //Italy
        case CH = "+41 (CH)"   //Switzerland
        case UK = "+44 (UK)"   //United Kingdom
        case DK = "+45 (DK)"   //Denmark
        case SE = "+46 (SE)"   //Sweden
        case NO = "+47 (NO)"   //Norway
        case PL = "+48 (PL)"   //Poland
        case DE = "+49 (DE)"   //Denmark
        case MX = "+52 (MX)"   //Mexico
        case CU = "+53 (CU)"   //Cuba
        case AR = "+54 (AR)"   //Argentina
        case BR = "+55 (BR)"   //Brazil
        case CL = "+56 (CL)"   //Chile
        case CO = "+57 (CO)"   //Colombia
        case VE = "+58 (VE)"   //Venezuela
        case MY = "+60 (MY)"   //Malaysia
        case AU = "+61 (AU)"   //Australia
        case ID = "+62 (ID)"   //Indonesia
        case PH = "+63 (PH)"   //Philippines
        case NZ = "+64 (NZ)"   //New Zealand
        case SG = "+65 (SG)"   //Singapore
        case TH = "+66 (TH)"   //Thailand
        case RU = "+7 (RU)"    //Russia
        case JP = "+81 (JP)"   //Japan
        case KR = "+82 (KR)"  //South Korea
        case VN = "+84 (VN)"   //Vietnam
        case HK = "+852 (HK)"  //Hong Kong
        case CN = "86 (CN)"   //China
        case TW = "886 (TW)"  //Taiwan
        case TR = "90 (TR)"   //Turkey
        case IN = "91 (IN)"   //India
        case PK = "92 (PK)"   //Pakistan
        case AF = "93 (AF)"   //Afghanistan
        
        var id: RawValue {
            self.rawValue
        }
    }
    var countryInfo: [Int: String] = [
        1: "+1 (US/CA)",
        31: "+31 (NR)",
        40: "+40 (ASD)"
    ]
    
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.001)
                .ignoresSafeArea()
                .background(
                    Image("Background1")
                        .resizable()
                        .ignoresSafeArea()
                )
            BackButton(path:$path)
                .padding([.top],20)
            VStack {
                LargeLogo()
                    .padding([.vertical],30)
                Text("Enter your phone number")
                    .font(.system(size:31,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                Text("This way, we can verify that your profile is real.")
                    .font(.system(size:16,weight:.regular))
                    .foregroundStyle(Helper.hexColor(hexCode: "#CCCCCC"))
                    .frame(maxWidth:361,alignment:.leading)
                    .padding([.vertical],20)
                Text("Telephone (No dashes required)")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth:361,alignment:.leading)
                HStack {
                    Picker("", selection: $country) {
                        ForEach(Country.allCases, id:\.self) { country in
                            HStack {
                                Text(country.rawValue)
                                Spacer()
                            }
                        }
                    }
                    .frame(width:130,height:43,alignment: .trailing)
                    .tint(Helper.hexColor(hexCode: "#B3B3B3"))
                    .clipShape(RoundedRectangle(cornerRadius:8))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Helper.hexColor(hexCode: "#CCCCCC"), lineWidth: 1)
                    )
                    TextField("", text: $phoneNum,
                        prompt: Text(verbatim: "123-456-7890")
                        .foregroundStyle(Helper.hexColor(hexCode: "#B3B3B3").opacity(0.5))
                    )
                        .padding([.leading,.trailing],16)
                        .padding([.vertical],12)
                        .foregroundStyle(Helper.hexColor(hexCode: "#B3B3B3"))
                        .frame(width:220,height:43)
                        .clipShape(RoundedRectangle(cornerRadius:8))
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Helper.hexColor(hexCode: "#CCCCCC"), lineWidth: 1)
                        )
                }
                .frame(maxWidth:361,alignment:.leading)
                Text("We will not share this information with anyone, and it will not appear on your profile.")
                    .font(.system(size:16,weight:.semibold))
                    .foregroundStyle(Helper.hexColor(hexCode: "#CCCCCC"))
                    .frame(maxWidth:361,alignment:.leading)
                    .padding([.top],40)
                Spacer()
                Button(action: {
                    //append path
                }) {
                    Text("Continue")
                        .font(.system(size:17,weight:.semibold))
                        .foregroundStyle(Helper.hexColor(hexCode: "#1A1A1A"))
                        .padding(10)
                        .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                .frame(width:361,height:40)
                .background(Helper.hexColor(hexCode: "#FFDD1A"))
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
    RegisterPhonePage(path:.constant(["Register Phone"]))
}
