//
//  Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class Post: NSObject {
    let body: String
    var uID: String
    let imageURL: String?
    let postID: String
    
    init(body: String, imageURL: String, uID: String, postID: String) {
        self.body = body
        self.imageURL = imageURL
        self.uID = uID
        self.postID = postID
    }
}
