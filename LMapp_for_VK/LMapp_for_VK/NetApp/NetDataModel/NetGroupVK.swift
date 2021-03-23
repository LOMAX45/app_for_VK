//
//  NetGroupVK.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.02.2021.
//

import Foundation
import RealmSwift

struct GroupResponse: Codable {
    let response: ItemsGroup
}

struct ItemsGroup: Codable {
    let count:Int
    let items:[GroupProperties]
}

struct GroupProperties: Codable {
    let id:Int
    let name:String
    let screenName:String
    let photo50:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case photo50 = "photo_50"
    }
}

class GroupPropertiesDb: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var screenName = ""
    @objc dynamic var photo50 = ""
    
    override init() {}
    
    convenience required init(id:Int, name: String, screenName: String, photo50: String) {
        self.init()
        self.id = id
        self.name = name
        self.screenName = screenName
        self.photo50 = photo50
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}



