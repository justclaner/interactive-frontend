//
//  NetworkManager.swift
//  Interactive
//
//  Created by Chris Y on 11/25/24.
//

import Foundation

enum NetworkError: String, Error {
    case networkError
    case invalidURL
}

class NetworkManager {
    static let instance = NetworkManager()
    
    let baseUrl = "http://localhost:3000"
    
    // func getProfile() async throws -> [Profile] // need "Profile.swift" struct
    //     {
    //         guard let url = URL(string: "\(baseUrl)/channels") else {
    //             throw NetworkError.invalidURL
    //         }
    //         var request = URLRequest(url: url)
    //         request.httpMethod = "GET"
    
    //         let (data, response) = try await URLSession.shared.data(for: request)
    
    //         guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode <= 299 else {
    //             throw NetworkError.networkError
    //         }
    
    //         return try JSONDecoder().decode([Channel].self, from: data)
    //     }
    


    // func updateProfile() async throws -> [Profile] // need "Profile.swift" struct
    //     {
    //         guard let url = URL(string: "\(baseUrl)/channels") else {
    //             throw NetworkError.invalidURL
    //         }
    //         var request = URLRequest(url: url)
    //         request.httpMethod = "POST"
    
    //         let (data, response) = try await URLSession.shared.data(for: request)
    
    //         guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode <= 299 else {
    //             throw NetworkError.networkError
    //         }
    
    //         return try JSONDecoder().decode([Channel].self, from: data)
    //     }
}
