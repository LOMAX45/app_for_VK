//
//  AddRealmObjectsOperation.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 02.04.2021.
//

import Foundation

class AddRealmObjectsOperation: Operation {
    
    let db = UsersDB()
    
    override func main() {
        print("START REALM")
        guard let dataParseOperation = dependencies.first as? DataParseOperation,
              let toAddData = dataParseOperation.outputData else { return }
        toAddData.forEach({ db.write($0.toUserVkDb()) })
        print("FINISHED REALM")
    }

    
}
