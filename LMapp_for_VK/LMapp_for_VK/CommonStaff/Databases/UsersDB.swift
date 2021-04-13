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
    
    func write(_ object: GroupPropertiesDb) {
        do {
            db?.beginWrite()
            db?.add(object, update: .all)
            try db?.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func write(_ object: ItemRealm) {
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
    
    func read(_ byId: Int) -> [ItemRealm]? {
        if let object = db?.objects(ItemRealm.self).filter("ownerId = \(byId)") {
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
    
    func delete(){
        do {
            db?.beginWrite()
            db?.deleteAll()
            try db?.commitWrite()
        } catch {
            print(error)
        }
    }
    
}
