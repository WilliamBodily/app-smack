//
//  AuthService.swift
//  Smack
//
//  Created by William Bodily on 11/25/18.
//  Copyright © 2018 William Bodily. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
        
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    completion(true)
                } catch {
                    completion(false)
                    debugPrint(data.debugDescription)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: AUTHORIZATION_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func updateUserById(name: String, completion: @escaping CompletionHandler) {
        
        let body: [String: Any] = [
            "name": name,
            "email": UserDataService.instance.email,
            "avatarName": UserDataService.instance.avatarName,
            "avatarColor": UserDataService.instance.avatarColor
        ]
        
        Alamofire.request("\(URL_USER)/\(UserDataService.instance.id)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: AUTHORIZATION_HEADER).responseString { (response) in
            print("RESPONSE: \(response.description)")
            if response.result.error == nil {
                self.setUserName(name: name)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_USER_BY_EMAIL)/\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: AUTHORIZATION_HEADER).responseJSON
            { (response) in
                
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    self.setUserInfo(data: data)
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }
    
    func setUserInfo(data: Data) {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let name = json["name"].stringValue
            let email = json["email"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            UserDataService.instance.setUserData(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor)
        } catch {
            debugPrint(data.debugDescription)
        }
    }
    
    func setUserName(name: String) {
        UserDataService.instance.setUserName(name: name)
    }
    
}
