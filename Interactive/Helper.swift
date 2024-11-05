//
//  Helper.swift
//  Interactive
//
//  Created by Justin Zou on 11/4/24.
//

import Foundation
import SwiftUI

/*
 Returns a Color given a color hexcode. Hexcode must be
 prefixed with '#' and be exactly 7 characters long.
 Characters after '#' must conform to the regex
 ([A-F]|\d). That is, all characters after '#' must be
 either digits or capital letters from A-F. The function
 will return Color.black for invalid hexcode strings.
 
 @param hexCode a 7-character string prefixed with '#'
 @return Color  a SwiftUI Color object
 */
class Helper {
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
}
