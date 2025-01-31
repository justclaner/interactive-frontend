//
//  LocationManager.swift
//  Interactive
//
//  Created by Chris Y on 11/25/24.
//

import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // Published properties to reflect UI updates
    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?
    @State private var data = UserData()
    
    
    static var longitude: Double?
    static var latitude: Double?

    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization() // Request permission
        //locationManager.startUpdatingLocation()         // Start location updates
    }
    

    // CLLocationManagerDelegate method for authorization changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            
            locationManager.startUpdatingLocation()  // Authorized: Start location updates
        case .denied, .restricted:
            print("Location access denied or restricted")
        default:
            break
        }
    }

    // CLLocationManagerDelegate method for location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        userLocation = newLocation  // Update the published location
        LocationManager.longitude = userLocation!.coordinate.longitude
        LocationManager.latitude = userLocation!.coordinate.latitude
        data.updateLocation(lat: LocationManager.latitude!, long: LocationManager.longitude!)
        print(userLocation!.timestamp, LocationManager.latitude!, LocationManager.longitude!)
        Task {
            do {
                let users = try await APIClient.fetchAllUsers()
                let usernames = users.users.map {
                    $0.username
                }
                print(usernames)
            } catch {
                print(error)
            }
        }
    }

    // CLLocationManagerDelegate method for handling errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    // Optional: Expose a method to manually request the current location
    func requestCurrentLocation() {
        locationManager.requestLocation()
    }
}
