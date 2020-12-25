//
//  NewsClass.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.12.2020.
//

import UIKit

class News {
    var header: String
    var body: String
    var pictures: [UIImage]
    var likes: UInt = UInt.random(in: 0..<253)
    var comments: [String]
    var reposts: UInt = UInt.random(in: 0..<78)
    var views: UInt = UInt.random(in: 0..<1354)
    
    init(header: String, body: String, pictures: [UIImage], likes: UInt, comments: [String], reposts: UInt, views: UInt) {
        self.header = header
        self.body = body
        self.pictures = pictures
        self.likes = likes
        self.comments = comments
        self.reposts = reposts
        self.views = views
    }
    
    init(header: String, body: String, pictures: [UIImage], comments: [String]) {
        self.header = header
        self.body = body
        self.pictures = pictures
        self.comments = comments
    }
    
    
    
    
}
