//
//  InstagramPost.swift
//  Benestar
//
//  Created by RYPE on 21/05/2015.
//  Copyright (c) 2015 Yourcreation. All rights reserved.
//

import Foundation

struct Post {
    let comments: Int
    let img: String
    let likes: Int
    let text: String
    let authorName: String
    let authorImg: String
    
    init(comments: Int, img: String, likes: Int, text: String, authorName: String, authorImg: String) {
        self.comments = comments
        self.img = img
        self.likes = likes
        self.text = text
        self.authorName = authorName
        self.authorImg = authorImg
    }
    
    /*************************************************/
     // Functions
     /*************************************************/
    static func postsWithJSON(results: NSArray) -> [Post] {
        var posts = [Post]()
        for postInfo in results {
            
            let json = JSON(postInfo)
            
            if let kind = json["type"].string {
                if kind=="image" {
                    
                    let postimgUrl = json["images"]["standard_resolution"]["url"].string
                    let postComments = json["comments"]["count"].int
                    let postLikes = json["likes"]["count"].int
                    var postText = json["caption"]["text"].string
                    
                    let postAuthorName = json["user"]["username"].string
                    let postAuthorImg = json["user"]["profile_picture"].string

                    
                    if(postText == nil){
                        postText = "There is no description or Tags for this publication."
                    }
                    
                    let post = Post(comments: postComments!, img: postimgUrl!, likes: postLikes!, text: postText!, authorName: postAuthorName!, authorImg: postAuthorImg!)
                    posts.append(post)
                    
                }
            }
        }
        return posts
    }
}