//
//  APICaller.swift
//  Interactive
//
//  Created by Justin Zou on 1/31/25.
//

import Foundation
class APIClient {
    
    
    static func fetchAllUsers() async throws -> UsersResponse {
        let url = URL(string: "https://interactive-backend.vercel.app/api/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UsersResponse.self, from: data)
        return decoded
    }
    
}

struct UsersResponse: Decodable {
    let success: Bool
    let users: [User]
}

struct User: Decodable {
    let _id: String
    let username: String
    let password: String
    let biography: String
    let is_company: Bool
    let is_premium: Bool
    let createdAt: String
    let updatedAt: String
    let __v: Int
    let latitude: [String: String]?
    let longitude: [String: String]?
}
