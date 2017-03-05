//
//  ConnectionManager.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import Foundation
import CoreLocation
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
    var parent: String?;
    var media: Media?;
    var description: String?;
    var latitude: Int!;
    var longitude: Int!;
    var timestamp: Int!;
    var upvotes: Int!;
    var downvotes: Int!;
    var comments: [Post]!;
}

fileprivate func getCurrentLocation() {
}

class ConnectionManager {
    func login(username: String, password: String){
        Just.post("http://lassondehacks.io:8089/auth/login", data: ["username": username, "password": password]){ r in
            if r.ok {
                DispatchQueue.global().async {
                    let defaults = UserDefaults.standard
                    defaults.setValue(username, forKey: defaultsKeys.email)
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
    
    func connect(_ username: String, _ password: String){
        let defaults = UserDefaults.standard
        Just.post("http://lassondehacks.io:8089/auth/login", data: ["username": username, "password": password]){ r in
            if r.ok {
                DispatchQueue.global().async {
                    defaults.setValue(r.headers["Set-Cookie"], forKey: defaultsKeys.cookie)
                    defaults.setValue(username, forKey: defaultsKeys.email)
                    defaults.setValue(password, forKey: defaultsKeys.password)
                    defaults.synchronize()
                }
            }
        }
    }
    
    func publish(_ image: UIImage, description: String! = "") {
        let defaults = UserDefaults.standard
        let location = (UIApplication.shared.delegate as! AppDelegate).getUserLocation()
        let fileData = (UIImagePNGRepresentation(image))!
        Just.post("http://lassondehacks.io:8089/post", data: ["longitude": location.coordinate.longitude, "latitude": location.coordinate.latitude, "description" : description],
                  headers: ["Cookie": defaults.string(forKey: defaultsKeys.cookie)!],
                  files: ["file": .data("filename", fileData, "image/png")])
        
        
    }
    
    func publish(_ description: String! = "") {
        let defaults = UserDefaults.standard
        Just.post("http://lassondehacks.io:8089/post", data: ["longitude": 0, "latitude": 0, "description" : description],
                      headers: ["Cookie": defaults.string(forKey: defaultsKeys.cookie)!])
    }
    
    func fetchHot(page: Int = 0, location: CLLocation) {
        let defaults = UserDefaults.standard
        let url = "http://lassondehacks.io:8089/post/hot/" + String(location.coordinate.longitude) + "/" + String(location.coordinate.latitude) + "/" + String(page) + "/" + String(10)
        Just.get(url, headers: ["Cookie": defaults.string(forKey: defaultsKeys.cookie)!]) { r in
                    if r.ok {
                        if let dict = r.json as? NSDictionary {
                            var postsArray = dict.value(forKey: "posts") as! Array<Any>
                            var posts = [Post]()
                            postsArray.forEach { post in
                                let postDict = post as? NSDictionary
                                let post = postDict?.value(forKey: "post") as? NSDictionary
                                let p = Post()
                                p._id = post?.value(forKey: "_id") as! String
                                p.description = post?.value(forKey: "description") as! String
                                p.timestamp = post?.value(forKey: "timestamp") as! Int
                                p.upvotes = post?.value(forKey: "timestamp") as! Int
                                p.downvotes = post?.value(forKey: "timestamp") as! Int
                                
                                posts.append(p)
                            }
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DataDidFinishLoading"), object: nil, userInfo: ["posts" : posts])
                        }
                    }
        }
    }
    
    func fetchRecent(page: Int = 0, location: CLLocation) {
        let defaults = UserDefaults.standard
        let url = "http://lassondehacks.io:8089/post/new/" + String(location.coordinate.longitude) + "/" + String(location.coordinate.latitude) + "/" + String(page) + "/" + String(10)
        Just.get(url, headers: ["Cookie": defaults.string(forKey: defaultsKeys.cookie)!]) { r in
            if r.ok {
                if let dict = r.json as? NSDictionary {
                    var postsArray = dict.value(forKey: "posts") as! Array<Any>
                    var posts = [Post]()
                    postsArray.forEach { post in
                        let postDict = post as? NSDictionary
                        let post = postDict?.value(forKey: "post") as? NSDictionary
                        let p = Post()
                        p._id = post?.value(forKey: "_id") as! String
                        p.description = post?.value(forKey: "description") as! String
                        p.timestamp = post?.value(forKey: "timestamp") as! Int
                        p.upvotes = post?.value(forKey: "timestamp") as! Int
                        p.downvotes = post?.value(forKey: "timestamp") as! Int
                        
                        posts.append(p)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DataDidFinishLoading"), object: nil, userInfo: ["posts" : posts])
                }
            }
        }
    }
    
    func fetchNear(page: Int = 0, location: CLLocation) {
        let defaults = UserDefaults.standard
        let url = "http://lassondehacks.io:8089/post/near/" + String(location.coordinate.longitude) + "/" + String(location.coordinate.latitude) + "/" + String(page) + "/" + String(10)
        Just.get(url, headers: ["Cookie": defaults.string(forKey: defaultsKeys.cookie)!]) { r in
            if r.ok {
                if let dict = r.json as? NSDictionary {
                    var postsArray = dict.value(forKey: "posts") as! Array<Any>
                    var posts = [Post]()
                    postsArray.forEach { post in
                        let postDict = post as? NSDictionary
                        let post = postDict?.value(forKey: "post") as? NSDictionary
                        let p = Post()
                        p._id = post?.value(forKey: "_id") as! String
                        p.description = post?.value(forKey: "description") as! String
                        p.timestamp = post?.value(forKey: "timestamp") as! Int
                        p.upvotes = post?.value(forKey: "timestamp") as! Int
                        p.downvotes = post?.value(forKey: "timestamp") as! Int
                        
                        posts.append(p)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DataDidFinishLoading"), object: nil, userInfo: ["posts" : posts])
                }
            }
        }
    }
    
    func fetchArchived(page: Int = 0, location: CLLocation) {
        let defaults = UserDefaults.standard
        let url = "http://lassondehacks.io:8089/posts"
        Just.get(url, headers: ["Cookie": defaults.string(forKey: defaultsKeys.cookie)!]) { r in
            if r.ok {
                if let dict = r.json as? NSDictionary {
                    var postsArray = dict.value(forKey: "posts") as! Array<Any>
                    var posts = [Post]()
                    postsArray.forEach { post in
                        let postDict = post as? NSDictionary
                        let post = postDict?.value(forKey: "post") as? NSDictionary
                        let p = Post()
                        p._id = post?.value(forKey: "_id") as! String
                        p.description = post?.value(forKey: "description") as! String
                        p.timestamp = post?.value(forKey: "timestamp") as! Int
                        p.upvotes = post?.value(forKey: "timestamp") as! Int
                        p.downvotes = post?.value(forKey: "timestamp") as! Int
                        
                        posts.append(p)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DataDidFinishLoading"), object: nil, userInfo: ["posts" : posts])
                }
            }
        }
    }
}

let Connection = ConnectionManager()
