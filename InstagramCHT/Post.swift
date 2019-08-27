//
//  Post.swift
//  InstagramCHT
//
//  Created by Alex Kravchook on 27.08.2019.
//  Copyright © 2019 DanKravchook. All rights reserved.
//

import Foundation

class Post{
    var caption: String?
    var photoUrl: String?
}

extension Post {
    static func transformPostPhoto(dict: [String: Any]) -> Post {
        let post = Post()
        post.caption = dict["caption"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        return post
    }
    
    static func transformPostVideo(){
        
    }
}
