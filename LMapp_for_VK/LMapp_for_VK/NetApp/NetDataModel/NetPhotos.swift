//
//  NetPhotos.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 29.03.2021.
//

import Foundation
import RealmSwift

struct Size: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int
}

struct Item: Codable {
    let albumId: Int
    let date: Int
    let id: Int
    let ownerId: Int
    let hasTags: Bool
    let sizes: [Size]
    let text: String
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case date
        case id
        case ownerId = "owner_id"
        case hasTags = "has_tags"
        case sizes
        case text
    }
}

struct Response: Codable {
    let count: Int
    let items: [Item]
}

struct PhotosJson: Codable {
    let response: Response
}


class SizeRealm: Object {
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var width: Int = 0
    let item = LinkingObjects(fromType: ItemRealm.self, property: "sizes")
    override init() {}
    convenience required init(height: Int, url: String, type: String, width: Int) {
        self.init()
        self.height = height
        self.url = url
        self.type = type
        self.width = width
    }
    override class func primaryKey() -> String? {
        return "url"
    }
}

class ItemRealm: Object {
    @objc dynamic var albumId: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var hasTags: Bool = false
    @objc dynamic var text: String = ""
    let sizes = List<SizeRealm>()
    override init() {}
    convenience required init(albumId: Int, date: Int, id: Int, ownerId: Int, hasTags: Bool, text: String) {
        self.init()
        self.albumId = albumId
        self.date = date
        self.id = id
        self.ownerId = ownerId
        self.hasTags = hasTags
        self.text = text
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}
