//
//  ContentView-ViewModel.swift
//  Interactive
//
//  Created by Justin Zou on 11/14/24.
//

import Foundation
import MapKit
import SwiftUI
import Combine



extension ContentView {
    @Observable
    class ViewModel {
        let initialPath : [String]
        var path: [String] = []
        let isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let debugPath = ["Home Page"]
        let debugMode: Bool = false
        

        
        
        init() {
            self.initialPath = isLoggedIn ? ["Your Profile"] : ["Login"]
            self.path = debugMode ? debugPath : initialPath
        }
        
        func getPath() -> [String] {
            return self.path
        }
        
        let updateLocationTimer = Timer.scheduledTimer(withTimeInterval: Control.updateLocationFrequencyInSeconds, repeats: true) { timer in
            if (Control.updatingLocation) {
                //print("updating location in ViewModel")
                Task {
                    do {
                        let updateLocation = try await APIClient.updateLocation()
                        print(updateLocation)
                        if (!updateLocation.success) {
                            print(updateLocation)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
    }
    
}
