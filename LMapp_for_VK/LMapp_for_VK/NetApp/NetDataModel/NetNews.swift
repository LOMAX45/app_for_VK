//
//  NetNews.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 24.03.2021.
//

import Foundation

struct Comments: Codable {
    let count: Int
}

struct Likes: Codable {
    let count: Int
}

struct Reposts: Codable {
    let count:Int
}

struct Views: Codable {
    let count: Int
}

struct NewsItem: Codable {
    let sourceId: Int
    let date: Int
    let postType: String
    let text: String
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let views: Views
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case postType = "post_type"
        case text
        case comments
        case likes
        case reposts
        case views
        case type
    }
    
}

struct NewsResponse: Codable {
    let items:[NewsItem]
    let profiles: [UserVK]
    let groups: [GroupProperties]
}

struct NewsJson: Codable {
    let response: NewsResponse
}

