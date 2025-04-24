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
}
