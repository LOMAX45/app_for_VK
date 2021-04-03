//
//  DataParseOperation.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 02.04.2021.
//

import Foundation

class DataParseOperation: Operation {
    
    var outputData: [UserVK]? = []
    
    override func main() {
        print("START PARSING")
        guard let getDataOperation = dependencies.first as? GetFriendsOperation,
              let data = getDataOperation.data
        else {
            return
        }
        do {
            let json = try JSONDecoder().decode(UsersResponse.self, from: data)
            let friends: [UserVK] = json.response
            outputData = friends
            print("FINISH PARSING")
        } catch {
            print(error)
        }
    }
    
}
