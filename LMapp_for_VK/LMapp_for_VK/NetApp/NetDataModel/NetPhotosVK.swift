//
//  NetPhotosVK.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.02.2021.
//

import Foundation
import RealmSwift

struct PhotosResponse: Codable {
    let response:ItemsPhoto
}

struct ItemsPhoto: Codable {
    let items:[Sizes]
}

struct Sizes: Codable {
    let id: Int
    let ownerId: Int
    let sizes: [PhotoProperties]
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
    }
}

struct PhotoProperties: Codable {
    let url: String
    let type: String
    
//    func toPhotoPropertiesDB() -> PhotoPropertiesDb {
//        return PhotoPropertiesDb(type: type, url: url)
//    }
}


class ItemsPhotoDb: Object {
    @objc dynamic var ownerId: Int = 0
    let items = List<SizesDb>()
//    let photoItems = LinkingObjects(fromType: UserVkDb.self, property: "photoItems")
    
    override init() {}
    
    convenience required init(ownerId: Int) {
        self.init()
        self.ownerId = ownerId
    }
    
    override class func primaryKey() -> String? {
        return "ownerId"
    }
    
}

class SizesDb: Object {
    @objc dynamic var ownerId: Int = 0
    let sizes = List<PhotoPropertiesDb>()
    let items = LinkingObjects(fromType: ItemsPhotoDb.self, property: "items")

    override init() {}
    
    convenience required init(ownerId: Int) {
        self.init()
        self.ownerId = ownerId
    }
    
    override class func primaryKey() -> String? {
        return "ownerId"
    }
}

class PhotoPropertiesDb: Object {
    @objc dynamic var type: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var photoId: Int = 0
    
    let sizes = LinkingObjects(fromType: SizesDb.self, property: "sizes")
    
    override init() {}
    
    convenience required init(type: String, url: String, photoId: Int) {
        self.init()
        self.type = type
        self.url = url
        self.photoId = photoId
    }
    
    override class func primaryKey() -> String? {
        return "url"
    }
}

