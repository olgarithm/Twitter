//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Olga Andreeva on 6/17/17.
//  Copyright © 2017 Olga Andreeva. All rights reserved.
//

import Foundation
import AlamofireImage

class User {
    
    var name: String
    var screenName: String?
    var profileImage: URL?
    var dictionary: [String: Any]?
    var following: Int?
    var followers: Int?
    var tweets: Int?
    private static var _current: User?
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as? String
        let profileURL = dictionary["profile_image_url_https"] as! String
        following = dictionary["friends_count"] as? Int
        followers = dictionary["followers_count"] as? Int
        tweets = dictionary["statuses_count"] as? Int
        profileImage = URL(string: profileURL)!
    }
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
