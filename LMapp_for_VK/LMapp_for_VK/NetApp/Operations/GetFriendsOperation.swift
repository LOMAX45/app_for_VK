//
//  GetFriendsOperation.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 02.04.2021.
//

import Foundation

class GetFriendsOperation: AsyncOperation {
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
    
    private var urlRequest: URLRequest
    private var dataTask: URLSessionDataTask?
    var data: Data?
    
    override func main() {
        print("START GET DATA")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, _ in
            guard let self = self else { return }
            self.data = data
            print("FINISH GET DATA")
            self.state = .finished
            
        }.resume()
        print("OPERATION FINISHED")
    }
    
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        super.init()
    }
    
    
}
