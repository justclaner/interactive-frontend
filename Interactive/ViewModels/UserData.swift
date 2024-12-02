//
//  UserData.swift
//  Interactive
//
//  Created by Justin Zou on 12/1/24.
//

import Foundation

class UserData {
    let defaults = UserDefaults.standard
    
    init() {
        defaults.set(LocationManager.latitude, forKey: "lat")
        defaults.set(LocationManager.longitude, forKey: "long")
    }
    
    
    //testing that data is indeed saved,
    //reconnect iphone after exiting app so that console logs can be shown again
    func incrementCounter() {
        defaults.set(defaults.integer(forKey: "counter") + 1, forKey: "counter")
    }
    
    func getCounter() -> Int {
        return defaults.integer(forKey: "counter")
    }
    
    func updateLocation(lat: Double, long: Double) {
        defaults.set(lat, forKey: "lat")
        defaults.set(long, forKey: "long")
    }
    
    func getLocation() -> (lat: Double, long: Double) {
        return (defaults.double(forKey: "lat"), defaults.double(forKey: "long"))
    }
}
