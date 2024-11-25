//
//  Helper.swift
//  Interactive
//
//  Created by Justin Zou on 11/4/24.
//

import Foundation
import SwiftUI

class Control {
    
    /*
     Returns a Color given a color hexcode. Hexcodes must be
     prefixed with '#' and be exactly 7 characters long.
     Characters after '#' must conform to the regex
     [A-F\d]. That is, all characters after '#' must be
     either digits or capital letters from A-F. The function
     will return Color.black for invalid hexcode strings.
     
     @param hexCode a 7-character string prefixed with '#'
                    and followed by a 6-character hex-string
     @return Color  a SwiftUI Color object
     */
    static func hexColor(hexCode: String) -> Color {
        let defaultColor: Color = Color.black
        
        let asciiTable: Dictionary<Int,Int> = [
            35: 0,
            48: 0,
            49: 1,
            50: 2,
            51: 3,
            52: 4,
            53: 5,
            54: 6,
            55: 7,
            56: 8,
            57: 9,
            65: 10,
            66: 11,
            67: 12,
            68: 13,
            69: 14,
            70: 15,
        ]
        
        if (hexCode.count != 7) {
            return defaultColor
        }
        //First character is not '#'
        if (Character(String(hexCode.prefix(1))).asciiValue != 35) {
            return defaultColor
        }
        
        var red: Int = 0
        var green: Int  = 0
        var blue: Int = 0
        
        for i in 1..<7 {
            let charAscii = Int(Character(String(hexCode.dropFirst(i).prefix(1))).asciiValue ?? 0)
            if (asciiTable[charAscii] == nil) {
                return defaultColor
            } else {
                switch i {
                case 1:
                    red += asciiTable[charAscii]!*16
                case 2:
                    red += asciiTable[charAscii]!
                case 3:
                    green += asciiTable[charAscii]!*16
                case 4:
                    green += asciiTable[charAscii]!
                case 5:
                    blue += asciiTable[charAscii]!*16
                case 6:
                    blue += asciiTable[charAscii]!
                default:
                    print("Character not found in Ascii Table")
                }
            }
        }
        
        let redFrac: Double = Double(red)/255
        let greenFrac: Double = Double(green)/255
        let blueFrac: Double = Double(blue)/255

        return Color(red: redFrac, green: greenFrac, blue: blueFrac)
    }
    
    /*
     Returns a string format of a Date object.
     @param date: Date          The Date object
     
     @param dateStyle: String   The specified string style for the day, month, and year.
                                In the en_US locale:
                                    "none"      No format
                                    "short"     "DD/MM/YY"
                                    "medium"    "[Abbreviated Month String] DD, YYYY"
                                    "long"      "[Month String] DD, YYYY"
                                    "full"      "[Day of Week], [Month String] DD, YYYY [Era String]"
                                Note that DD and MM will be truncated to 1 character when possible.
                                dateStyle defaults to "full" when typed incorrectly.
     
    @param timeStyle: String    The specific string style for the time
                                In the en_US locale:
                                    "none"      No format
                                    "short"     "[Hour]:[Minute]"
                                    "medium"    "[Hour]:[Minute]:[Second] [Period]"     (Period is AM/PM)
                                    "long"      "[Hour]:[Minute]:[Second] [Period] [Time Zone Abbreviation]"
                                    "full"      "[Hour]:[Minute]:[Second] [Period] [Time Zone Full Text]"
                                timeStyle defaults to "full" when typed incorrectly.
     
    @param locale: String       A 5-character string, where the first two characters is a lowercase
                                abbreviation of the language, the third character is a dash ("-"), and
                                the fourth and fifth character is an uppercase abbreviation of the
                                region. Examples include "en-US", "zh-CN", and "fr-FR". For more information,
                                see https://www.techonthenet.com/js/language_tags.php
                                If typed incorrectly, the locale will default to en-US.
     @return String             A string format of the date given.
     */
    static func dateToString(date: Date, dateStyle: String, timeStyle: String, locale: String) -> String {
        let dateFormatter = DateFormatter()
        
        switch dateStyle {
        case "none":
            dateFormatter.dateStyle = .none
        case "short":
            dateFormatter.dateStyle = .short
        case "medium":
            dateFormatter.dateStyle = .medium
        case "long":
            dateFormatter.dateStyle = .long
        default:
            dateFormatter.dateStyle = .full
        }
        
        switch timeStyle {
        case "none":
            dateFormatter.timeStyle = .none
        case "short":
            dateFormatter.timeStyle = .short
        case "medium":
            dateFormatter.timeStyle = .medium
        case "long":
            dateFormatter.timeStyle = .long
        default:
            dateFormatter.timeStyle = .full
        }

        dateFormatter.locale = Locale(identifier: locale)
        
        return dateFormatter.string(from: date)
    }
    /*
     A dictionary of all country abbreviations and calling codes, sorted by country code (US at top)
     Country abbreviations are according to the ISO 3166-1 Alpha-2 Standard, and the calling codes
     are according to the International Telecommunication Union (ITU). For more information see:
     https://en.wikipedia.org/wiki/List_of_country_calling_codes    for calling codes
     https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes   for country abbreivations
     
     TO-DO: fill in remaining countries in sorted order
     */
    static let countryCode : Dictionary<String,Int> = [
        "US": 1,    //United States
        "CA": 1,    //Canada
        "EG": 20,   //Egypt
        "SS": 211,  //South Sudan
        "MA": 212,  //Morocco
        "DZ": 213,  //Algeria
        "TN": 216,  //Tunisia
        "LY": 218,  //Libya
        "GH": 233,  //Ghana
        "GL": 299,  //Greenland
        "NL": 31,   //Netherlands
        "BE": 32,   //Belgium
        "FR": 33,   //France
        "ES": 34,   //Spain
        "PT": 351,  //Portugal
        "LU": 352,  //Luxembourg
        "IE": 353,  //Ireland
        "IS": 354,  //Iceland
        "AL": 355,  //Albania
        "FI": 358,  //Finland
        "IT": 39,   //Italy
        "CH": 41,   //Switzerland
        "UK": 44,   //United Kingdom
        "DK": 45,   //Denmark
        "SE": 46,   //Sweden
        "NO": 47,   //Norway
        "PL": 48,   //Poland
        "DE": 49,   //Denmark
        "MX": 52,   //Mexico
        "CU": 53,   //Cuba
        "AR": 54,   //Argentina
        "BR": 55,   //Brazil
        "CL": 56,   //Chile
        "CO": 57,   //Colombia
        "VE": 58,   //Venezuela
        "MY": 60,   //Malaysia
        "AU": 61,   //Australia
        "ID": 62,   //Indonesia
        "PH": 63,   //Philippines
        "NZ": 64,   //New Zealand
        "SG": 65,   //Singapore
        "TH": 66,   //Thailand
        "RU": 7,    //Russia
        "JP": 81,   //Japan
        "KR": 82,   //South Korea
        "VN": 84,   //Vietnam
        "HK": 852,  //Hong Kong
        "CN": 86,   //China
        "TW": 886,  //Taiwan
        "TR": 90,   //Turkey
        "IN": 91,   //India
        "PK": 92,   //Pakistan
        "AF": 93,   //Afghanistan
    ]
    
    /*
     The length of the verification code sent by SMS to the user in order to
     verify their phone number.
     */
    static let phoneVerificationCodeLength = 6
}
