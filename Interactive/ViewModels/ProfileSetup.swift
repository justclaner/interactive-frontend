//
//  ProfileSetup.swift
//  Interactive
//
//  Created by Justin Zou on 11/27/24.
//

import Foundation

struct ProfileSetup {
    static var bypass = false
    static var data = UserData()
    static var inTutorial: Bool = bypass ? false : data.getInTutorial()
    static var tutorialStep: Int = 0
    static let tutorialBlackOpacity: Double = 0.6
    static let tutorialWhiteOpacity: Double = 0.3
    
    static var addedImage = false
    static var addedBio = false
    
    static var lastStep = 4
}


