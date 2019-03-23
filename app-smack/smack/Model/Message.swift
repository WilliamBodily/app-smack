//
//  Message.swift
//  Smack
//
//  Created by William Bodily on 3/23/19.
//  Copyright © 2019 William Bodily. All rights reserved.
//

import Foundation

struct Message : Decodable {
    public private(set) var _id: String!
    public private(set) var messageBody: String!
    public private(set) var userId: String!
    public private(set) var channelId: String!
    public private(set) var userName: String!
    public private(set) var userAvatar: String!
    public private(set) var userAvatarColor: String!
    public private(set) var __v: Int?
    public private(set) var timestamp: String!
}
