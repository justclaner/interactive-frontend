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
        var path: [String] = []
        let isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
        init() {
            self.initialPath = isLoggedIn ? ["Your Profile"] : ["Login"]
            self.path = initialPath
        }
        
        func getPath() -> [String] {
            return self.path
        }
        
        let updateLocationTimer = Timer.scheduledTimer(withTimeInterval: Control.updateLocationFrequencyInSeconds, repeats: true) { timer in
            if (Control.updatingLocation) {
                print(Control.updatingLocation)
                Task {
                    do {
                        let updateLocation = try await APIClient.updateLocation()
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
