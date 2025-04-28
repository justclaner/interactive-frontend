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
    static let localTesting: Bool = true
    static let baseURL: String = localTesting ? "http://localhost:3000" : "https://interactive-backend-eight.vercel.app"
    struct UsersResponse: Decodable {
        let success: Bool
        let users: [User]?
        let message: String?
        let error: String?
    }
    
    struct UserResponse: Decodable {
        let success: Bool
        let user: User?
        let message: String?
        let error: String?
    }
    
    struct User: Decodable {
        let _id: String
        let username: String
        let email: String
        let biography: String?
        let password: String
        let birthDay: Int
        let birthMonth: String
        let birthYear: Int
        let is_company: Bool
        let is_premium: Bool
        let visitors: Int?
        let interactions: Int?
        let createdAt: String
        let updatedAt: String
        let __v: Int
    }
    
    struct UserImagesResponse: Decodable {
        let success: Bool
        let images: UserImages
        let error: String?
        let message: String?
    }
    
    struct UserImages: Decodable {
        let _id: String
        let user_id: String
        let image1: String?
        let image2: String?
        let image3: String?
        let image4: String?
        let image5: String?
        let createdAt: String
        let updatedAt: String
        let __v: Int
    }
    
    struct SocialMediaLinksResponse: Decodable {
        let success: Bool
        let count: Int
        let message: String
        let socialMediaLinks: [SocialMediaLink]?
    }
    
    struct SocialMediaLink: Decodable {
        let _id: String
        let user_id: String
        let social_media_name: String
        let social_media_url: String
        let createdAt: String
        let updatedAt: String
        let __v: Int
    }
    
    struct NotificationsResponse: Decodable {
        let success: Bool
        let message: String?
        let notifications: [Notification]?
    }
    
    struct NotificationResponse: Decodable {
        let success: Bool
        let message: String?
        let notification: Notification?
    }
    
    struct Notification: Decodable {
        let _id: String
        let sender_id: String
        let recipient_id: String
        let action: String
        let createdAt: String
        let updatedAt: String
        let __v: Int
    }
    
    struct InteractionResponse: Decodable {
        let success: Bool
        let message: String?
        let interaction: Interaction?
        let interactions: [Interaction]?
    }
    
    struct Interaction: Decodable {
        let _id: String
        let user1_id: String
        let user2_id: String
        let createdAt: String
        let updatedAt: String
        let __v: Int
    }
    
    struct UsernameExistResponse: Decodable {
        let success: Bool
        let exists: Bool
        let message: String
    }
    
    struct DefaultResponse: Decodable {
        let success: Bool
        let error: String?
        let message: String?
        let user: User?
        let socialMediaLink: SocialMediaLink?
    }
    
    struct UserLocationResponse: Decodable {
        let success: Bool
        let error: String?
        let message: String?
        let locations: [UserLocationStruct]?
    }
    
    struct UserLocationStruct: Decodable {
        let location: LocationStruct
        let _id: String
        let user_id: String
        let createdAt: String
        let updatedAt: String
        let __v: Int
    }
    
    struct LocationStruct: Decodable {
        let type: String
        let coordinates: [Double]
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
    
    struct EmptyBody: Encodable {
    }
    
    
    static func postRequest(url: String, body: Encodable) async throws -> DefaultResponse {
        let urlString = URL(string: url)!
        let encoded = try Control.encode(jsonBody: body)
        
        var request = URLRequest(url: urlString)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        print(String(data: data, encoding: .utf8)!)
        let decoded = try JSONDecoder().decode(DefaultResponse.self, from: data)
        return decoded
    }
    
    static func putRequest(url: String, body: Encodable) async throws -> DefaultResponse {
        let urlString = URL(string: url)!
        let encoded = try Control.encode(jsonBody: body)
        
        var request = URLRequest(url: urlString)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        let decoded = try JSONDecoder().decode(DefaultResponse.self, from: data)
        return decoded
    }
    
    static func deleteRequest(url: String, body: Encodable) async throws -> DefaultResponse {
        let urlString = URL(string: url)!
        let encoded = try Control.encode(jsonBody: body)
        
        var request = URLRequest(url: urlString)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        
        let decoded = try JSONDecoder().decode(DefaultResponse.self, from: data)
        return decoded
    }
    
    static func fetchAllUsers() async throws -> UsersResponse {
        let url = URL(string: "\(baseURL)/api/us/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UsersResponse.self, from: data)
        return decoded
    }
    
    static func fetchUser(userId: String) async throws -> UserResponse {
        let url = URL(string: "\(baseURL)/api/us/users/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UserResponse.self, from: data)
        return decoded
    }
    
    static func fetchUserNetworks() async throws -> SocialMediaLinksResponse {
        let url = URL(string: "\(baseURL)/api/us/sm/user/\(UserDefaults.standard.string(forKey: "userId") ?? "")")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(SocialMediaLinksResponse.self, from: data)
        return decoded
    }
    
    static func fetchUserNetworksFromId(userId: String) async throws -> SocialMediaLinksResponse {
        let url = URL(string: "\(baseURL)/api/us/sm/user/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(SocialMediaLinksResponse.self, from: data)
        return decoded
    }
    
    static func fetchNearbyUsers() async throws -> UserLocationResponse {
        let url = URL(string: "\(baseURL)/api/us/location/search")!
        let body: Encodable = [
            "latitude": UserDefaults.standard.double(forKey: "lat"),
            "longitude": UserDefaults.standard.double(forKey: "long"),
            "maxDistance": 250
        ]

        let encoded = try Control.encode(jsonBody: body)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
    
        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        let decoded = try JSONDecoder().decode(UserLocationResponse.self, from: data)

        return decoded
    }
    
    static func fetchNotificationFromRecipient(recipientId: String) async throws -> NotificationsResponse {
        let url = URL(string: "\(baseURL)/api/us/connections/recipient/\(recipientId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(NotificationsResponse.self, from: data)
        return decoded
    }
    
    
    static func fetchNotification(notificationId: String) async throws -> NotificationResponse {
        let url = URL(string: "\(baseURL)/api/us/connections/notification/\(notificationId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(NotificationResponse.self, from: data)
        return decoded
    }
    
    //gets interaction between two users if it exists
    static func fetchInteraction(user1Id: String, user2Id: String) async throws -> InteractionResponse {
        let url = URL(string: "\(baseURL)/api/us/interactions/\(user1Id)/\(user2Id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(InteractionResponse.self, from: data)
        return decoded
    }
    
    //gets interaction request (notification) if it exists
    static func fetchInteractionRequest(senderId: String, recipientId: String) async throws -> NotificationResponse {
        let url = URL(string: "\(baseURL)/api/us/connections/existingRequest/\(senderId)/\(recipientId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(NotificationResponse.self, from: data)
        return decoded
    }
    
    static func fetchContacts(userId: String) async throws -> InteractionResponse {
        let url = URL(string: "\(baseURL)/api/us/interactions/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(InteractionResponse.self, from: data)
        return decoded
    }
    
    static func resolveNotification(notificationId: String, action: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/connections/resolve"
        let body: Encodable = [
            "notificationId": notificationId,
            "action": action
        ]
        //print(body)
        return try await postRequest(url: url, body: body)
    }
    
    static func authenticateUser(email: String, password: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/users/auth"
        let body: Encodable = [
            "email": email,
            "password": password
        ]
        return try await postRequest(url: url, body: body)
    }
    
    static func createUser(body: Encodable) async throws -> DefaultResponse {
        return try await postRequest(url: "\(baseURL)/api/us/users", body: body)
    }
    
    static func createNetworkLink(platformName: String, url: String) async throws -> DefaultResponse {
        let queryUrl = "\(baseURL)/api/us/sm/"
        let body: Encodable = [
            "user_id": UserDefaults.standard.string(forKey: "userId") ?? "",
            "social_media_name": platformName,
            "social_media_url": url
        ]
        print(body)
        return try await postRequest(url: queryUrl, body: body)
    }
    
    static func createInteractionRequest(senderId: String, recipientId: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/connections/"
        let body: Encodable = [
            "senderId": senderId,
            "recipientId": recipientId,
            "action": "InteractRequest"
        ]
        
        return try await postRequest(url: url, body: body)
    }
    
    static func createInteraction(userId1: String, userId2: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/interactions/"
        let body: Encodable = [
            "user1_id": userId1,
            "user2_id": userId2
        ]
        
        return try await postRequest(url: url, body: body)
    }
    
    
    static func getUserFromUsername(username: String) async throws -> UserResponse {
        let url = URL(string: "\(baseURL)/api/us/users/fetchFromUsername/\(username)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UserResponse.self, from: data)
        return decoded
    }
    
    static func checkUsernameExist(username: String) async throws -> UsernameExistResponse {
        let url = URL(string: "\(baseURL)/api/us/users/username/\(username)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UsernameExistResponse.self, from: data)
        return decoded
    }
    
    static func getPresignedPostURL() async throws -> PresignedPostUrlResponse {
        let url = URL(string: "\(baseURL)/api/us/images")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(PresignedPostUrlResponse.self, from: data)
        return decoded
    }
    
    
    static func uploadImageToS3(userId: String, imageIndex: String, image: UIImage, presignedPostResult: PresignedPostUrlResponse) async throws -> Void {
        let userExists = try await fetchUser(userId: userId)
        if (userExists.success == false) {
            return
        }
        
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
        
        
        let uploadToBackend = try await uploadImageURLToBackend(userId: userId, imageIndex: imageIndex, imageURL: "\(data.url)\(data.fields.key)")
        if (!uploadToBackend.success) {
            return
        }
        UserDefaults.standard.set(true, forKey: "\(imageIndex)Loading")
        DispatchQueue.main.asyncAfter(deadline: .now() + Control.showTemporaryImageInterval) {
            UserDefaults.standard.set("\(data.url)\(data.fields.key)", forKey: imageIndex)
            UserDefaults.standard.set(false, forKey: "\(imageIndex)Loading")
        }
    }
    
    static func uploadImageURLToBackend(userId: String, imageIndex: String, imageURL: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/images/userImage/\(userId)"
        let body: Encodable = [
            "imageIndex": imageIndex,
            "imageURL": imageURL
        ]
        print(url)
        print(body)
        return try await postRequest(url: url, body: body)
    }
    
    static func updateUsername(username: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/users/\(UserDefaults.standard.string(forKey:"userId") ?? "")"
        let body: Encodable = [
            "username": username
        ]
        
        return try await putRequest(url: url, body: body)
    }
    
    static func updateBio(bio: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/users/\(UserDefaults.standard.string(forKey:"userId") ?? "")"
        let body: Encodable = [
            "biography": bio
        ]
        
        return try await putRequest(url: url, body: body)
    }
    
    static func updateLink(oldUrl: String, platform: String, newUrl: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/sm/";
        let body: Encodable = [
            "userId": UserDefaults.standard.string(forKey:"userId") ?? "",
            "oldUrl": oldUrl,
            "social_media_name": platform,
            "newUrl": newUrl
        ]
        return try await putRequest(url: url, body: body)
    }
    
    static func updateLocation() async throws -> DefaultResponse {
        //print("updating location")
        let url = "\(baseURL)/api/us/location/";
        let body: Encodable = [
            "userId": UserDefaults.standard.string(forKey:"userId") ?? "",
            "latitude": String(UserDefaults.standard.double(forKey:"lat")),
            "longitude": String(UserDefaults.standard.double(forKey:"long"))
        ]
        return try await putRequest(url: url, body: body)
    }
    
    static func fetchUserImages(userId: String) async throws -> UserImagesResponse {
        let url = URL(string: "\(baseURL)/api/us/users/images/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(UserImagesResponse.self, from: data)
        return decoded
    }
    
    static func deleteUserImage(imageURL: String, imageIndex: String, userId: String) async throws -> DefaultResponse {
        
        let url = "\(baseURL)/api/us/images/\(imageURL.suffix(36))"
        
        let body: Encodable = [
            "imageIndex": imageIndex,
            "userId": userId
        ]
    
        return try await deleteRequest(url: url, body: body)
    }
    
    static func deleteUserSocialMediaLink(linkURL: String) async throws -> DefaultResponse {
        let queryURL = "\(baseURL)/api/us/sm/"
        
        let body: Encodable = [
            "userId": UserDefaults.standard.string(forKey:"userId") ?? "",
            "url": linkURL
        ]
        
        return try await deleteRequest(url: queryURL, body: body)
    }
    
    static func deleteNotification(notificationId: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/connections/"
        let body: Encodable = [
            "notificationId": notificationId
        ]
        
        return try await deleteRequest(url: url, body: body)
    }
    
    static func deleteInteraction(user1Id: String, user2Id: String) async throws -> DefaultResponse {
        let url = "\(baseURL)/api/us/interactions/"
        let body: Encodable = [
            "user1_id": user1Id,
            "user2_id": user2Id
        ]
        
        return try await deleteRequest(url: url, body: body)
    }
    
}
