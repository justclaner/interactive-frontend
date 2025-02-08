//
//  ContentView-ViewModel.swift
//  Interactive
//
//  Created by Justin Zou on 11/14/24.
//

import Foundation
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        let initialPath : [String]
        var path: [String]
        let inTutorial: Bool = UserDefaults.standard.bool(forKey: "inTutorial")
        init() {
            self.initialPath = inTutorial ? ["Login"] : ["Your Profile"]
            self.path = initialPath
        }
    }
    
}
