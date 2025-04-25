//
//  SocketService.swift
//  Interactive
//
//  Created by Justin Zou on 4/25/25.
//

import Foundation
import SocketIO

class SocketService {
    static let shared = SocketService()
    
    let manager: SocketManager
    let socket: SocketIOClient

    private init() {
        self.manager = SocketManager(socketURL: URL(string: SocketClient.connectionURL)!, config: [.log(true), .compress])
        self.socket = manager.defaultSocket
        //print("attempting to connect via socket.io")
        self.socket.on(clientEvent: .connect) { data, ack in
           // print("socket connected")
        }
        self.socket.connect()
    }
}
