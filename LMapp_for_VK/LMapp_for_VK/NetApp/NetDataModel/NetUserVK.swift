//
//  NetUserVK.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 17.02.2021.
//

import Foundation
import RealmSwift

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
    
    //convertation
    func toUserVkDb() -> UserVkDb {
        return UserVkDb(id: id,
                        firstName: firstName,
                        lastName: lastName,
                        avatar: avatar)
    }
}

class UserVkDb: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatar: String = ""
    
//    let photoItems = List<PhotoPropertiesDb>()
    
    override init() {}
    
    convenience required init(id: Int, firstName: String, lastName: String, avatar: String) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    //convertation
    func toUserVK() -> UserVK {
        return UserVK(id: id,
                      firstName: firstName,
                      lastName: lastName,
                      avatar: avatar)
    }
    
}
