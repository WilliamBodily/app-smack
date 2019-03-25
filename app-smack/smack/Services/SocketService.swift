//
//  SocketService.swift
//  Smack
//
//  Created by William Bodily on 3/23/19.
//  Copyright © 2019 William Bodily. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    let CHANNEL_NAME = 0
    let CHANNEL_DESCRIPTION = 1
    let CHANNEL_ID = 2
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", name, description)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (data, ack) in
            guard let channelName = data[0] as? String else { return }
            guard let channelDescription = data[1] as? String else { return }
            guard let channelId = data[2] as? String else { return }
            
            let jsonData: JSON = ["_id": channelId, "name": channelName, "description": channelDescription, "__v": 0]
            
            do {
                let newChannel = try JSONDecoder().decode(Channel.self, from: jsonData.rawData())
                MessageService.instance.channels.append(newChannel)
            } catch let error {
                debugPrint(error as Any)
            }
            
            completion(true)
        }
    }
    
    func addMessage(body: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", body, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getMessage(completion: @escaping (_ newMessage: Message) -> Void) {
        socket.on("messageCreated") { (data, ack) in
            guard let messageBody = data[0] as? String else { return }
            guard let userId = data[1] as? String else { return }
            guard let channelId = data[2] as? String else { return }
            guard let userName = data[3] as? String else { return }
            guard let userAvatar = data[4] as? String else { return }
            guard let userAvatarColor = data[5] as? String else { return }
            guard let messageId = data[6] as? String else { return }
            guard let timeStamp = data[7] as? String else { return }
            
            let jsonData: JSON = ["_id": messageId, "message": messageBody, "userId": userId, "channelId": channelId, "userName": userName, "userAvatar": userAvatar, "userAvatarColor": userAvatarColor]
            
            do {
                let newMessage = try JSONDecoder().decode(Message.self, from: jsonData.rawData())
                completion(newMessage)
            } catch let error {
                debugPrint(error as Any)
            }
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping(_ typingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (data, ack) in
            guard let typingUsers = data[0] as? [String: String]
                else { return }
            completionHandler(typingUsers)
        }
    }

}
