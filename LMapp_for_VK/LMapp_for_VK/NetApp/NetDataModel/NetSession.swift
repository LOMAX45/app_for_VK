//
//  NetSession.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 17.02.2021.
//

import Foundation

class NetSession {
    
    static let instance = NetSession()
    
    var currentUser:UserVK?
    var token:String = ""
    var userId:Int = 0
    
    private init(){}
    
}
