//
//  NewsDB.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 24.03.2021.
//

import Foundation

class NewsDatabase {
    
    static let shared = NewsDatabase()
    
    var jsonObject: Data?
    
    var items: [NewsItem] = []
    var profiles: [UserVK] = []
    var groups: [GroupProperties] = []
    
    private init(){}
    
}
