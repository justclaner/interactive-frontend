//
//  Helper.swift
//  Interactive
//
//  Created by Justin Zou on 11/4/24.
//

import Foundation
import SwiftUI

class Helper {
    
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
}
