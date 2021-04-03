//
//  GetFriendsOperation.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 02.04.2021.
//

import Foundation

class GetFriendsOperation: AsyncOperation {
    
    let networkManager = NetworkManager()
    let apiMethod: ApiMethods
    
    var data: Data?
    
    override func main() {
        
        networkManager.getJson(method: apiMethod) { [weak self] data in
            guard let self = self else { return }
            self.data = data
            self.state = .finished
        }
    }
    
    init(apiMethod: ApiMethods) {
        self.apiMethod = apiMethod
        super.init()
    }
    
    
}
