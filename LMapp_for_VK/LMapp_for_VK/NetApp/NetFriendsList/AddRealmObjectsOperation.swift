//
//  AddRealmObjectsOperation.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 02.04.2021.
//

import Foundation

class AddRealmObjectsOperation: Operation {
    
    let db = UsersDB()
    var isStoredFriends:[UserVkDb] = []
    var outputData:[UserVkDb] = []
    
    override func main() {
        guard let dataParseOperation = dependencies.first as? DataParseOperation,
              let toAddData = dataParseOperation.outputData else { return }
        DispatchQueue.main.async {
            self.isStoredFriends = self.db.read() ?? []
            if toAddData.count < self.isStoredFriends.count {
                self.db.delete()
            }
            toAddData.forEach({ self.db.write($0.toUserVkDb()) })
            self.outputData = self.db.read() ?? []
        }
    }
    
    
}
