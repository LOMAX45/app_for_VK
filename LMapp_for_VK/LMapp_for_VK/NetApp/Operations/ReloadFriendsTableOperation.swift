//
//  ReloadFriendsTableOperation.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 03.04.2021.
//

import Foundation

class ReloadFriendsTableOperation: Operation {
    var controller: FriendsListController
    
    init(controller: FriendsListController) {
        self.controller = controller
    }
    
    override func main() {
        guard let updateRealm = dependencies.first as? AddRealmObjectsOperation else { return }
        controller.friends = updateRealm.outputData
        if controller.friends.count != 0 {
            controller.sort(array: controller.friends)
            controller.tableView.reloadData()
        }
    }
}
