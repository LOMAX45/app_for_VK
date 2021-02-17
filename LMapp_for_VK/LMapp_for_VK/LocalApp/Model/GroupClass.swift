//
//  GroupClass.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

class Group: Equatable {
    
    var name: String
    var description: String = "Описание не было добавлено при создании"
    var owner: User
    var admin: User? = nil
    var avatar: UIImage = UIImage(systemName: "questionmark.diamond")!
    
    init(name: String, owner: User) {
        self.name = name
        self.owner = owner
    }
    
    init(name: String, owner: User, avatar: UIImage) {
        self.name = name
        self.owner = owner
        self.avatar = avatar
    }
    
    init(name: String, owner: User, avatar: UIImage, description: String) {
        self.name = name
        self.owner = owner
        self.avatar = avatar
        self.description = description
    }
    
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.name == rhs.name
    }
    
    func changeGroup (name: String) {
        self.name = name
    }
    
    func changeGroup (description: String) {
        self.description = description
    }
    
    func changeGroup (owner: User) {
        self.owner = owner
    }
    
    func changeGroup (admin: User) {
        self.admin = admin
    }
    
    func changeGroup (avatar: UIImage) {
        self.avatar = avatar
    }
    
}
