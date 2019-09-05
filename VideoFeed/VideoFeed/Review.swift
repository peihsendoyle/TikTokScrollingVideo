//
//  Video.swift
//  VideoFeed
//
//  Created by Doyle Illusion on 9/5/19.
//  Copyright © 2019 Lixi Technologies. All rights reserved.
//

import Foundation

class Review {
    var videoUrl : String?
    var placeholderUrl : String?
    var title: String?
    var body: String?
    var user : User?
    var tags : [Tag]?
    var likeCount : String?
    var commentCount : String?
    var starCount : String?
    
    init(videoUrl: String, placeholderUrl: String, title: String, body: String, user: User, tags: [Tag], likeCount: String, commentCount: String, starCount: String) {
        self.videoUrl = videoUrl
        self.placeholderUrl = placeholderUrl
        self.title = title
        self.body = body
        self.user = user
        self.tags = tags
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.starCount = starCount
    }
}
