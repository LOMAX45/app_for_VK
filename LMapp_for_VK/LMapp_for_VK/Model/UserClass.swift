//
//  UserClass.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

enum Gender {
    case male
    case female
    case unspecified
}

class User: Equatable, Comparable{
    
    var nickname: String
    var password: String
    var name: String
    var familyName: String
    var emailAddress: String
    var dayOfBorn: UInt8
    var monthOfBorn: UInt8
    var yearOfBorn:UInt16
    var age: UInt16
    var gender: Gender
    var avatar: UIImage
    var photosLibrary: [UIImage]
    var memberOf: [Group]
    
    init(nickname: String, name: String, familyName: String, emailAddress: String, dayOfBorn: UInt8, monthOfBorn: UInt8, yearOfBorn: UInt16, avatar: UIImage, photosLibrary: [UIImage]) {
        self.nickname = nickname
        self.password = " "
        self.name = name
        self.familyName = familyName
        self.emailAddress = emailAddress
        self.dayOfBorn = dayOfBorn
        self.monthOfBorn = monthOfBorn
        self.yearOfBorn = yearOfBorn
        self.gender = Gender.unspecified
        self.age = UInt16((Date().description.split(separator: "-"))[0])! - yearOfBorn
        self.avatar = avatar
        self.photosLibrary = photosLibrary
        self.memberOf = []
    }
    
    init(nickname: String, password: String, name: String, familyName: String, emailAddress: String, dayOfBorn: UInt8, monthOfBorn: UInt8, yearOfBorn: UInt16, avatar: UIImage, memberOf: [Group]) {
        self.nickname = nickname
        self.password = password
        self.name = name
        self.familyName = familyName
        self.emailAddress = emailAddress
        self.dayOfBorn = dayOfBorn
        self.monthOfBorn = monthOfBorn
        self.yearOfBorn = yearOfBorn
        self.gender = Gender.unspecified
        self.age = UInt16((Date().description.split(separator: "-"))[0])! - yearOfBorn
        self.avatar = avatar
        self.photosLibrary = []
        self.memberOf = memberOf
    }
    
    init(nickname: String, password: String, name: String, familyName: String) {
        self.nickname = nickname
        self.password = password
        self.name = name
        self.familyName = familyName
        self.emailAddress = ""
        self.dayOfBorn = 0
        self.monthOfBorn = 0
        self.yearOfBorn = 0
        self.gender = Gender.unspecified
        self.age = 0
        self.avatar = UIImage(systemName: "person")!
        self.photosLibrary = []
        self.memberOf = []
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.nickname == rhs.nickname
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.nickname < rhs.nickname
    }
    
    func check (inputedLogin: String, inputedPassword: String) -> Bool {
        return self.nickname == inputedLogin && self.password == inputedPassword
    }
    
    func updatePersonalData (nickname: String) {
        self.nickname = nickname
    }
    
    func updatePersonalData (name: String) {
        self.name = name
    }
    
    func updatePersonalData (familyName: String) {
        self.familyName = familyName
    }
    
    func updatePersonalData (emailAddress: String) {
        self.emailAddress = emailAddress
    }
    
    func updatePersonalData(dayOfBorn: UInt8) {
        self.dayOfBorn = dayOfBorn
    }
    
    func updatePersonalData(monthOfBorn: UInt8) {
        self.monthOfBorn = monthOfBorn
    }
    
    func updatePersonalData(yearOfBorn: UInt16) {
        self.yearOfBorn = yearOfBorn
        self.age = UInt16((Date().description.split(separator: "-"))[0])! - self.yearOfBorn
    }
    
    func updatePersonalData (gender: Gender) {
        self.gender = gender
    }
    
    func updatePersonalData (avatar: UIImage) {
        self.avatar = avatar
    }
    
    func addPhoto (photo: UIImage) {
        self.photosLibrary.append(photo)
    }
    
    func removePhoto (photoId: Int) {
        self.photosLibrary.remove(at: photoId)
    }
    
}
