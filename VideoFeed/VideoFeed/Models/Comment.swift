//
//  Comment.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/6/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import Foundation

class Comment {
    var user: User?
    var content : String?
    var date : String?
    var likeCount : String?
    
    var subcomments: [Comment]?
    
    init(user: User, content: String, date: String, likeCount: String, subcomments: [Comment]) {
        self.user = user
        self.content = content
        self.date = date
        self.likeCount = likeCount
        self.subcomments = subcomments
    }
}
