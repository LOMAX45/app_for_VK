//
//  demo_database.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

let admin = User(nickname: "admin", password: "admin", name: "admin", familyName: "admin")

var listOfUsersDemo:[User] = [
    User(nickname: "Хорошая Девочка", name: "Алена", familyName: "Апина", emailAddress: "alena.apina@geekbrains.ru", dayOfBorn: 13, monthOfBorn: 02, yearOfBorn: 1969, avatar: (UIImage(named: "girl_1")!)),
    User(nickname: "Велелый Кабанчик", name: "Виктор", familyName: "Кабанов", emailAddress: "victor.kabanov@geekbrains.ru", dayOfBorn: 23, monthOfBorn: 12, yearOfBorn: 1976, avatar: (UIImage(named: "boar")!)),
    User(nickname: "Удивленная Сова", name: "Антонина", familyName: "Совина", emailAddress: "antonina.sovina@geekbrains.ru", dayOfBorn: 24, monthOfBorn: 05, yearOfBorn: 1991, avatar: (UIImage(named: "owl")!)),
    User(nickname: "Грустная Обезьянка", name: "Эльвира", familyName: "Мартышкина", emailAddress: "elvira.martyshkina@geekbrains.ru", dayOfBorn: 7, monthOfBorn: 09, yearOfBorn: 1983, avatar: (UIImage(named: "monkey")!)),
    User(nickname: "Робот Под Напряжением", name: "Геннадий", familyName: "Роботов", emailAddress: "gennadiy.robotov@geekbrains.ru", dayOfBorn: 17, monthOfBorn: 10, yearOfBorn: 1979, avatar: (UIImage(named: "robot")!)),
    User(nickname: "Гуманоид В Шоке", name: "Алексей", familyName: "Внеземной", emailAddress: "alexey.vnezemnoy@geekbrains.ru", dayOfBorn: 29, monthOfBorn: 02, yearOfBorn: 1952, avatar: (UIImage(named: "humanoid")!)),
    User(nickname: "Апатичная Какашка", name: "Альфред", familyName: "Запахов", emailAddress: "alfred.zapahov@geekbrains.ru", dayOfBorn: 31, monthOfBorn: 07, yearOfBorn: 1981, avatar: (UIImage(named: "piece_of_shit")!)),
    User(nickname: "Злобный Свинтус", name: "Григорий", familyName: "Поросенкин", emailAddress: "grigory.porosenkin@geekbrains.ru", dayOfBorn: 13, monthOfBorn: 01, yearOfBorn: 1995, avatar: (UIImage(named: "pig")!)),
    User(nickname: "Сонная Панда", name: "Юля", familyName: "Медведева", emailAddress: "julia.medvedeva@geekbrains.ru", dayOfBorn: 26, monthOfBorn: 03, yearOfBorn: 1986, avatar: (UIImage(named: "panda")!)),
    User(nickname: "Выносящий Дракон", name: "Сергей", familyName: "Мозгов", emailAddress: "sergey.mozgov@geekbrains.ru", dayOfBorn: 14, monthOfBorn: 11, yearOfBorn: 1974, avatar: (UIImage(named: "dragon")!)),
    User(nickname: "Милая Коала", name: "Елена", familyName: "Запонкина", emailAddress: "elena.zaponkina@geekbrains.ru", dayOfBorn: 18, monthOfBorn: 08, yearOfBorn: 1990, avatar: (UIImage(named: "koala")!))
]

var currentUser:User = admin

let dragon_description = "Драко́н (греч. δράκων) — собирательное название, объединяющее ряд мифологических и фантастических существ. Дракон связан с христианским культом святого Георгия и получил широкое распространение в европейском религиозном искусстве. Традиции Восточной Азии также содержат немало драконообразных персонажей, таких как японский рю (竜), китайский лун (龍), вьетнамский лонг (龍), корейский ён (용) и др.В XX и XXI веках интерес к дракону усилился и продолжает усиливаться. По утверждению В. Н. Дёмина, «идёт драконий бум», у фантастических жанров любых форм — картины, книги, кинематограф, интернет-сайты и компьютерные игры имеют огромное количество поклонников[1]. Дракон нашёл широкое распространение в фэнтези, а также используется в фэншуй и астрологии (год дракона)."

var groupsDemo: [Group] = [
    Group(name: "Сообщество девочек", owner: listOfUsersDemo[0], avatar: UIImage(named: "girls")!),
    Group(name: "Сообщество кабанчиков", owner: listOfUsersDemo[1], avatar: UIImage(named: "boars")!),
    Group(name: "Сообщество сов", owner: listOfUsersDemo[2], avatar: UIImage(named: "owls")!),
    Group(name: "Сообщество обезьян", owner: listOfUsersDemo[3], avatar: UIImage(named: "monkeys")!),
    Group(name: "Сообщество роботов", owner: listOfUsersDemo[4], avatar: UIImage(named: "robots")!),
    Group(name: "Сообщество гуманоидов", owner: listOfUsersDemo[5], avatar: UIImage(named: "humanoids")!),
    Group(name: "Сообщество какашек", owner: listOfUsersDemo[6], avatar: UIImage(named: "pieces_of_shit")!),
    Group(name: "Сообщество свинтусов", owner: listOfUsersDemo[7], avatar: UIImage(named: "pigs")!),
    Group(name: "Сообщество панд", owner: listOfUsersDemo[8], avatar: UIImage(named: "pandas")!),
    Group(name: "Сообщество драконов", owner: listOfUsersDemo[9], avatar: UIImage(named: "dragons")!, description: dragon_description),
    Group(name: "Сообщество коал", owner: listOfUsersDemo[10], avatar: UIImage(named: "koalas")!)
]

var demoUserMemberOf: [Group] = [groupsDemo[6], groupsDemo[8], groupsDemo[9]]

let demoUser = User(nickname: "lomax45", password: "password", name: "Максим", familyName: "Лосев", emailAddress: "maxim.losev@geekbrains.ru", dayOfBorn: 02, monthOfBorn: 06, yearOfBorn: 1988, avatar: (UIImage(named: "avatar"))!, memberOf: demoUserMemberOf)
