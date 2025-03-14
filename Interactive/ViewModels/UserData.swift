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
        if (defaults.object(forKey: "inTutorial") == nil) {
            defaults.set(true, forKey: "inTutorial")
        }
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
    
    func setInTutorial(complete: Bool) {
        defaults.set(complete, forKey: "inTutorial")
    }
    
    func getInTutorial() -> Bool {
        return defaults.bool(forKey: "inTutorial")
    }
    
    func cleanCompleteStorage() {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadFromUserJSON(user: APIClient.User, password: String) {
        UserDefaults.standard.set(user._id, forKey: "userId")
        UserDefaults.standard.set(user.username, forKey: "username")
        UserDefaults.standard.set(user.email, forKey: "email")
        if (user.biography != nil) {
            UserDefaults.standard.set(user.biography!, forKey: "biography")
        }
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(user.birthDay, forKey: "birthDay")
        UserDefaults.standard.set(user.birthMonth, forKey: "birthMonth")
        UserDefaults.standard.set(user.birthYear, forKey: "birthYear")
        
        loadImages(userId: user._id)
        
        UserDefaults.standard.set(false, forKey:"inTutorial")
    }
    
    func loadImages(userId: String) {
        Task {
            do {
                let imagesResponse = try await APIClient.fetchUserImages(userId: userId)
                if (imagesResponse.success) {
                    if (imagesResponse.images.image1 != nil) {
                        UserDefaults.standard.set(imagesResponse.images.image1!, forKey: "image1")
                    }
                    if (imagesResponse.images.image2 != nil) {
                        UserDefaults.standard.set(imagesResponse.images.image2!, forKey: "image2")
                    }
                    if (imagesResponse.images.image3 != nil) {
                        UserDefaults.standard.set(imagesResponse.images.image3!, forKey: "image3")
                    }
                    if (imagesResponse.images.image4 != nil) {
                        UserDefaults.standard.set(imagesResponse.images.image4!, forKey: "image4")
                    }
                    if (imagesResponse.images.image5 != nil) {
                        UserDefaults.standard.set(imagesResponse.images.image5!, forKey: "image5")
                    }
                }
            }
        }
    }
}
