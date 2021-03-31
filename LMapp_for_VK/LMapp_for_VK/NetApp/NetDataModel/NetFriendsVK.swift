//
//  NetFriendsVK.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.02.2021.
//

import Foundation
import RealmSwift

struct FriendsResponse: Codable {
    let response:Items
}

struct Items: Codable {
    let items:[UserVK]
}
