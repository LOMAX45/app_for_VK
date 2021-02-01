//
//  Session.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 01.02.2021.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    var currentUser:User = admin
    var token:String = ""
    var userId:Int = 0
    
    private init(){}
    
}
