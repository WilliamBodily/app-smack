//
//  Constants.swift
//  Smack
//
//  Created by William Bodily on 11/23/18.
//  Copyright © 2018 William Bodily. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://devslopeschatapplesson.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER = "\(BASE_URL)user"
let URL_USER_ADD = "\(URL_USER)/add"
let URL_USER_BY_EMAIL = "\(URL_USER)/byEmail"
let URL_GET_CHANNELS = "\(BASE_URL)channel"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"

// Colors
let PURPLE_PLACEHOLDER_TEXT = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

// Notifications
let NOTIFICATION_USER_DATA_CHANGE = Notification.Name("notificationUserDataChange")
let NOTIFICATION_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIFICATION_CHANNEL_SELECTED = Notification.Name("channelSelected")

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
let AUTHORIZATION_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]

// Avatars
let TOTAL_AVATAR_CHOOSABLES = 28
