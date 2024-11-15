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
        var path : [String] = ["Login"]
    }
    
}

class GlobalVariables {
    static let global = GlobalVariables()
    @Published var test = 0;
}
