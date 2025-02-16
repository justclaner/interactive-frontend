//
//  APICaller.swift
//  Interactive
//
//  Created by Justin Zou on 1/31/25.
//

import Foundation
import SwiftUICore
import UIKit


class APIClient {
    static let localTesting: Bool = false
    static let baseURL: String = localTesting ? "http://localhost:3000" : "https://interactive-backend-eight.vercel.app"
    struct UsersResponse: Decodable {
        let success: Bool
        let users: [User]
    }
    
    struct User: Decodable {
        let _id: String
        let username: String
        let password: String
        let biography: String
        let birthDay: Int
        let birthMonth: String
        let birthYear: Int
        let is_company: Bool
        let is_premium: Bool
        let createdAt: String
        let updatedAt: String
        let __v: Int
        let latitude: [String: String]?
        let longitude: [String: String]?
    }
    
    struct UsernameExistResponse: Decodable {
        let success: Bool
        let exists: Bool
        let message: String
    }
    
    struct DefaultResponse: Decodable {
        let success: Bool
        let message: String
    }
    
    struct PresignedPostUrlResponse: Decodable {
        let url: String
        let fields: PresignedPostUrlFields
    }
    
    struct PresignedPostUrlFields: Decodable {
        let contentType: String
        let bucket: String
        let xAmzAlgorithm: String
        let xAmzCredential: String
        let xAmzDate: String
        let key: String
        let Policy: String
        let xAmzSignature: String
        
        enum CodingKeys: String, CodingKey {
            case contentType = "Content-Type"
            case bucket
            case xAmzAlgorithm = "X-Amz-Algorithm"
            case xAmzCredential = "X-Amz-Credential"
            case xAmzDate = "X-Amz-Date"
            case key
            case Policy
            case xAmzSignature = "X-Amz-Signature"
        }
        
    }
    
    
    static func fetchAllUsers() async throws -> UsersResponse {
        let url = URL(string: "\(baseURL)/api/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UsersResponse.self, from: data)
        return decoded
    }
    
    static func postRequest(url: String, body: Encodable) async throws -> DefaultResponse {
        let url = URL(string: url)!
        let encoded = try Control.encode(jsonBody: body)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        let decoded = try JSONDecoder().decode(DefaultResponse.self, from: data)
        return decoded
    }
    
    static func authenticateUser(userId: String, password: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/users/auth"
        let body: Encodable = [
            "userId": userId,
            "password": password
        ]
        return try await postRequest(url: url, body: body)
    }
    
    static func checkUsernameExist(username: String) async throws -> UsernameExistResponse {
        let url = URL(string: "\(baseURL)/api/users/username/\(username)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UsernameExistResponse.self, from: data)
        return decoded
    }
    
    static func getPresignedPostURL() async throws -> PresignedPostUrlResponse {
        let url = URL(string: "\(baseURL)/api/images")!
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(PresignedPostUrlResponse.self, from: data)
        return decoded
    }
    
    static func uploadImageToS3(image: UIImage, presignedPostResult: PresignedPostUrlResponse) async throws -> Void {
        let data = presignedPostResult
        let url = URL(string: data.url)!
        
        let textFields: [[String]] = [
            ["bucket", data.fields.bucket],
            ["key", data.fields.key],
            ["Content-Type", "image/jpeg"],
            ["X-Amz-Credential", data.fields.xAmzCredential],
            ["X-Amz-Date", data.fields.xAmzDate],
            ["Policy", data.fields.Policy],
            ["X-Amz-Algorithm", data.fields.xAmzAlgorithm],
            ["X-Amz-Signature", data.fields.xAmzSignature],
        ]
        print(textFields)
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let separator = "\r\n--\(boundary)\r\n".data(using:.utf8)!
        var body = Data()
        
        textFields.forEach { field in
            body.append(separator)
            body.append("Content-Disposition: form-data; name=\"\(field[0])\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(field[1])".data(using: .utf8)!)
        }
        
        body.append("\r\n--\(boundary)\r\n".data(using:.utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(image.jpegData(compressionQuality: 0.9)!)
        body.append("\r\n--\(boundary)--\r\n".data(using:.utf8)!)
        
        request.setValue(String(body.count), forHTTPHeaderField: "Content-Length")
        print(String(body.count))
        
        print("Content-Length: \(body.count)")
        print(String(data: body, encoding: .utf8) ?? "Invalid body")
        
        print(body)
        
        URLSession.shared.uploadTask(with: request, from: body, completionHandler: { data, response, error in
            if (error != nil) {
                print("\(error!.localizedDescription)")
            } else {
                guard let data = data else {
                    print("No response data")
                    return
                }
                if let responseString = String(data: data, encoding: .utf8) {
                    print(responseString)
                }
            }
        }).resume()
    }
    
    static func uploadImageToBackend(userId: String, imageKey: String, imageURL: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/users/images/userImage/\(userId)"
        let body: Encodable = [
            "imageKey": imageKey,
            "imageURL": imageURL
        ]
        return try await postRequest(url: url, body: body)
    }
}
