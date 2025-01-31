//
//  APICaller.swift
//  Interactive
//
//  Created by Justin Zou on 1/31/25.
//

import Foundation
class APIClient {
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

    struct AuthResponse: Decodable {
        let success: Bool
        let message: String
    }

    
    
    static func fetchAllUsers() async throws -> UsersResponse {
        let url = URL(string: "https://interactive-backend.vercel.app/api/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UsersResponse.self, from: data)
        return decoded
    }
    
    static func authenticateUser(userId: String, password: String) async throws -> AuthResponse {
        let url = URL(string: "https://interactive-backend.vercel.app/api/users/auth")!
        let body: Encodable = [
            "userId": userId,
            "password": password
        ]
        let encoded = try JSONEncoder().encode(body)
        
        print(String(data: encoded, encoding: .utf8)!)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        let decoded = try JSONDecoder().decode(AuthResponse.self, from: data)
        return decoded
    }
    
}
