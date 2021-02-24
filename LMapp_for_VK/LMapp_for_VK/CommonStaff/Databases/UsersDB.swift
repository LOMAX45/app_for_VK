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
        db = try? Realm()
        print(db?.configuration.fileURL)
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
    
    func read() -> [UserVkDb]? {
        if let object = db?.objects(UserVkDb.self) {
            return Array(object)
        }
        return nil
    }
    
}
