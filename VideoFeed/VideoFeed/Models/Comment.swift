//
//  Comment.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/6/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import Foundation

class Comment {
    var id : String?
    var user: User?
    var content : String?
    var imageUrl: String?
    var date : String?
    var likeCount : String?
    
    var subcomments: [Comment]?
    
    init(id: String, user: User, content: String, imageUrl: String? = nil, date: String, likeCount: String, subcomments: [Comment]) {
        self.id = id
        self.user = user
        self.imageUrl = imageUrl
        self.content = content
        self.date = date
        self.likeCount = likeCount
        self.subcomments = subcomments
    }
}
