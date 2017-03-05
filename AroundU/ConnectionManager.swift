//
//  ConnectionManager.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import Foundation
import Just

class Media {
    var _id: String?;
    var mimetype: String!;
    var name: String!;
    var size: Int!;
    var url: String!;
}

class Post {
    var _id: String?;
    var user: String!;
    var parent: String?;
    var media: Media?;
    var description: String?;
    var latitude: Int!;
    var longitude: Int!;
    var timestamp: Date!;
    var upvotes: Int!;
    var downvotes: Int!;
    var comments: [Post]!;
}

class ConnectionManager {
    func login(username: String, password: String){
//        let r = Just.post("http://lassondehacks.io:8089/auth/login", data: ["username": email.text!, "password": password.text!])
//        if r.ok {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loggedIn"), object: nil)
//            let defaults = UserDefaults.standard
//            if let dict = r.json as? NSDictionary {
//                defaults.setValue(dict.value(forKey: "username"), forKey: defaultsKeys.username)
//            }
//            defaults.setValue(r.headers["Set-Cookie"], forKey: defaultsKeys.cookie)
//            defaults.setValue(password.text!, forKey: defaultsKeys.password)
//            defaults.synchronize()
//        }
        
        Just.post("http://lassondehacks.io:8089/auth/login", data: ["username": username, "password": password]){ r in
            if r.ok {
                DispatchQueue.global().async {
                    let defaults = UserDefaults.standard
                    if let dict = r.json as? NSDictionary {
                        defaults.setValue(dict.value(forKey: "username"), forKey: defaultsKeys.username)
                    }
                    defaults.setValue(r.headers["Set-Cookie"], forKey: defaultsKeys.cookie)
                    defaults.setValue(password, forKey: defaultsKeys.password)
                    defaults.synchronize()
                }
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loggedIn"), object: nil)
                }
            }
        }
    }
}

let Connection = ConnectionManager()
