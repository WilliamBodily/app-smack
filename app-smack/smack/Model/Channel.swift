//
//  Channel.swift
//  Smack
//
//  Created by William Bodily on 3/14/19.
//  Copyright © 2019 William Bodily. All rights reserved.
//

import Foundation

struct Channel : Decodable {
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int?
}
