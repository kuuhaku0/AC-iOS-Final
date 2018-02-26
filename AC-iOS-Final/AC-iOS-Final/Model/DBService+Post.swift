//
//  DBService+Jobs.swift
//  firebase stuff
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DBService {
    
    //Func below gets all the posts using a completion handler
    public func getAllPosts(completion: @escaping (_ posts: [Post]) -> Void) {
        postsRef.observe(.value) { (dataSnapshot) in
            var posts: [Post] = []
            guard let postSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for postSnapshot in postSnapshots {
                guard let postObject = postSnapshot.value as? [String: Any] else {
                    return
                }
                guard let body = postObject["body"] as? String,
                    let uID = postObject["uID"] as? String,
                    let postID = postObject["postID"] as? String
                    else { print("error getting posts");return}
                
                let imageURL = postObject["imageURL"] as? String

                let thisPost = Post(body: body, imageURL: imageURL ?? "", uID: uID, postID: postID)
                posts.append(thisPost)
                
            }
            DBService.manager.posts = posts
            completion(posts)
        }
    }
    
    func getCurrentUserPosts() -> [Post] {
        guard let userId = AuthUserService.getCurrentUser()?.uid else {print("cant get current users posts"); return []}
        return posts.filter{ $0.uID ==  userId}
    }
    
    func newPost(body: String, image: UIImage?) {
        guard let currentUser = AuthUserService.getCurrentUser() else {print("could not get current user"); return}
        let ref = postsRef.childByAutoId()
        let post = Post(body: body, imageURL: "", uID: currentUser.uid, postID: ref.key)
        ref.setValue(["body": post.body,
                      "postID": post.postID,
                      "uID": currentUser.uid,
            ])
        StorageService.manager.storePostImage(image: image, postID: post.postID)
    }
    
    public func addImageToPost(url: String, postID: String) {
        addImage(url: url, ref: postsRef, id: postID)
    }
    
    public func deletePost(with postID: String) {
        postsRef.child(postID).removeValue()
        self.delegate?.didDeletePost!(self)
    }
}


