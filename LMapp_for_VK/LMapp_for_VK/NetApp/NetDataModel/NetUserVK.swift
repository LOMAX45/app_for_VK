//
//  NetUserVK.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 17.02.2021.
//

import Foundation

struct Response: Decodable {
    let users: [UserVK]
    
    enum CodingKeys: String, CodingKey {
        case users = "response"
    }
}

struct UserVK: Decodable {
    
    let id: Int
    var firstName: String
    var lastName: String
    var canAccessClosed: Bool
    var isClosed: Bool
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case avatar = "photo_50"
    }
    
}
