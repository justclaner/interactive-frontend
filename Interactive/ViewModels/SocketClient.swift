//
//  SocketClient.swift
//  Interactive
//
//  Created by Justin Zou on 4/24/25.
//

import Foundation

class SocketClient {
    struct connectionBody: Decodable {
        let senderId: String
        let recipientId: String
    }
    
    static let debugging = true
    static let connectionURL = debugging ? "http://localhost:3002" : "some ec2 instance"
    
    static func getData(dict: [String: Any]) -> SocketClient.connectionBody? {
        var body: SocketClient.connectionBody!
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            body = try JSONDecoder().decode(SocketClient.connectionBody.self, from: jsonData)
        } catch {
            print(error)
        }
        return body
    }
}
