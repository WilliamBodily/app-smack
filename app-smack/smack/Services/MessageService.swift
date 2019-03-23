//
//  MessageService.swift
//  Smack
//
//  Created by William Bodily on 3/14/19.
//  Copyright © 2019 William Bodily. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selecteChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: AUTHORIZATION_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                NotificationCenter.default.post(name: NOTIFICATION_CHANNELS_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func findAllMessagesForChannel(id: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: AUTHORIZATION_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                
                do {
                    let message = try JSONDecoder().decode([Message].self, from: data)
                    self.messages.append(message[0])
                } catch let error {
                    debugPrint(error as Any)
                }
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
}
