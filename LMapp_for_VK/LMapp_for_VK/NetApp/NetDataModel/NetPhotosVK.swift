//
//  NetPhotosVK.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.02.2021.
//

import Foundation

struct PhotosResponse: Codable {
    let response:ItemsPhoto
}

struct ItemsPhoto: Codable {
    let items:[Sizes]
}

struct Sizes: Codable {
    let sizes: [PhotoProperties]
}

struct PhotoProperties: Codable {
    let url: String
}
