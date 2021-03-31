//
//  NetUserVK.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 17.02.2021.
//

import Foundation

struct UsersResponse: Codable {
    let response: [UserVK]
}

struct UserVK: Codable {
    let id: Int
    var firstName: String
    var lastName: String
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
    }
}



