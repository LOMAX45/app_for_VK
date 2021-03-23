//
//  DatabaseClass.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 24.02.2021.
//

import Foundation
import RealmSwift

class UsersDB {
    
    private var db: Realm?
    
    init() {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            db = try Realm(configuration: config)
            print(db?.configuration.fileURL)
        } catch {
            print(error)
        }
        
    }
    
    func write(_ object:UserVkDb) {
        do {
            db?.beginWrite()
            db?.add(object, update: .all)
            try db?.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func write(_ object:PhotoPropertiesDb) {
        do {
            db?.beginWrite()
            db?.add(object, update: .all)
            try db?.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func write(_ object:SizesDb) {
        do {
            db?.beginWrite()
            db?.add(object, update: .all)
            try db?.commitWrite()
        } catch {
            print(error)
        }
    }

    func write(_ object:ItemsPhotoDb) {
        do {
            db?.beginWrite()
            db?.add(object, update: .all)
            try db?.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func write(_ object: GroupPropertiesDb) {
        do {
            db?.beginWrite()
            db?.add(object, update: .all)
            try db?.commitWrite()
        } catch {
            print(error)
        }
    }
    
    
    func read() -> [UserVkDb]? {
        if let object = db?.objects(UserVkDb.self) {
            return Array(object)
        }
        return nil
    }
     
    func read() -> [SizesDb]? {
        if let object = db?.objects(SizesDb.self) {
            return Array(object)
        }
        return nil
    }
    
    func read(_ byId: Int) -> [SizesDb]? {
        if let object = db?.objects(SizesDb.self).filter("ownerId = \(byId)") {
            return Array(object)
        }
        return nil
    }
    
    func read() -> [PhotoPropertiesDb]? {
        if let object = db?.objects(PhotoPropertiesDb.self) {
            return Array(object)
        }
        return nil
    }
    
    func read() -> [GroupPropertiesDb]? {
        if let object = db?.objects(GroupPropertiesDb.self) {
            return Array(object)
        }
        return nil
    }
    
}
