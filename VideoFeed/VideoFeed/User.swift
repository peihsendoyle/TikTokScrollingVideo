//
//  User.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/5/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import Foundation

class User {
    var avatarUrl : String?
    var name : String?
    var level : String?
    
    init(avatarUrl: String, name: String, level: String) {
        self.avatarUrl = avatarUrl
        self.name = name
        self.level = level
    }
}
