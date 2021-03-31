//
//  NewsClass.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.12.2020.
//

import UIKit

class News {
    var owner: User
    var creationDate: String
    var body: String
    var pictures: [UIImage]
    var likes: UInt = UInt.random(in: 0..<253)
    var numbersOfComments: UInt = UInt.random(in: 0..<253)
    var comments: [String]
    var reposts: UInt = UInt.random(in: 0..<78)
    var views: UInt = UInt.random(in: 0..<1354)
    var likedBy: [User] = []
    
    init(owner: User, creationDate: String, body: String, pictures: [UIImage], likes: UInt, comments: [String], reposts: UInt, views: UInt) {
        self.owner = owner
        self.creationDate = creationDate
        self.body = body
        self.pictures = pictures
        self.likes = likes
        self.comments = comments
        self.reposts = reposts
        self.views = views
    }
    
    init(owner: User, creationDate: String, body: String, pictures: [UIImage], comments: [String], likedBy: [User]) {
        self.owner = owner
        self.creationDate = creationDate
        self.body = body
        self.pictures = pictures
        self.comments = comments
        self.likedBy = likedBy
    }
    
}

extension News: Comparable {
    
    static func < (lhs: News, rhs: News) -> Bool {
        lhs.creationDate < rhs.creationDate
    }
    
    static func == (lhs: News, rhs: News) -> Bool {
        lhs.creationDate == rhs.creationDate
    }
    
}
