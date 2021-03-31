//
//  demo_database.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

let admin = User(nickname: "admin", password: "admin", name: "admin", familyName: "admin")

var girlsPhotos:[UIImage] = [UIImage(named:"gl-ph1")!, UIImage(named:"gl-ph2")!, UIImage(named:"gl-ph3")!, UIImage(named:"gl-ph4")!, UIImage(named:"gl-ph5")!]
var boarsPhotos:[UIImage] = [UIImage(named:"br-ph1")!, UIImage(named:"br-ph2")!, UIImage(named:"br-ph3")!, UIImage(named:"br-ph4")!, UIImage(named:"br-ph5")!]
var owlsPhotos:[UIImage] = [UIImage(named:"owl-ph1")!, UIImage(named:"owl-ph2")!, UIImage(named:"owl-ph3")!, UIImage(named:"owl-ph4")!, UIImage(named:"owl-ph5")!, UIImage(named:"owl-ph6")!, UIImage(named:"owl-ph7")!]
var monkeysPhotos:[UIImage] = [UIImage(named:"mk-ph1")!, UIImage(named:"mk-ph2")!, UIImage(named:"mk-ph3")!, UIImage(named:"mk-ph4")!, UIImage(named:"mk-ph5")!, UIImage(named:"mk-ph6")!]
var robotsPhotos:[UIImage] = [UIImage(named:"rb-ph1")!, UIImage(named:"rb-ph2")!, UIImage(named:"rb-ph3")!, UIImage(named:"rb-ph4")!, UIImage(named:"rb-ph5")!, UIImage(named:"rb-ph6")!, UIImage(named:"rb-ph7")!, UIImage(named:"rb-ph8")!]
var humanoidsPhotos:[UIImage] = [UIImage(named:"hm-ph1")!, UIImage(named:"hm-ph2")!, UIImage(named:"hm-ph3")!, UIImage(named:"hm-ph4")!, UIImage(named:"hm-ph5")!, UIImage(named:"hm-ph6")!, UIImage(named:"hm-ph7")!, UIImage(named:"hm-ph8")!, UIImage(named:"hm-ph9")!, UIImage(named:"hm-ph10")!, UIImage(named:"hm-ph11")!]
var piecesPhotos:[UIImage] = [UIImage(named:"pc-ph1")!, UIImage(named:"pc-ph2")!, UIImage(named:"pc-ph3")!, UIImage(named:"pc-ph4")!, UIImage(named:"pc-ph5")!, UIImage(named:"pc-ph6")!, UIImage(named:"pc-ph7")!, UIImage(named:"pc-ph8")!, UIImage(named:"pc-ph9")!]
var pigsPhotos:[UIImage] = [UIImage(named:"pg-ph1")!, UIImage(named:"pg-ph2")!, UIImage(named:"pg-ph3")!]
var pandasPhotos:[UIImage] = [UIImage(named:"pn-ph1")!, UIImage(named:"pn-ph2")!, UIImage(named:"pn-ph3")!, UIImage(named:"pn-ph4")!, UIImage(named:"pn-ph5")!]
var dragonsPhotos:[UIImage] = [UIImage(named:"dr-ph1")!, UIImage(named:"dr-ph2")!, UIImage(named:"dr-ph3")!, UIImage(named:"dr-ph4")!, UIImage(named:"dr-ph5")!, UIImage(named:"dr-ph6")!]
var koalasPhotos:[UIImage] = [UIImage(named:"kl-ph1")!, UIImage(named:"kl-ph2")!, UIImage(named:"kl-ph3")!, UIImage(named:"kl-ph4")!]
var demoUsersPhotos:[UIImage] = [UIImage(named:"dmUsr-ph1")!, UIImage(named:"dmUsr-ph2")!, UIImage(named:"dmUsr-ph3")!, UIImage(named:"dmUsr-ph4")!, UIImage(named:"dmUsr-ph5")!]


var listOfUsers:[User] = [
    User(nickname: "Хорошая Девочка", name: "Алена", familyName: "Апина", emailAddress: "alena.apina@geekbrains.ru", dayOfBorn: 13, monthOfBorn: 02, yearOfBorn: 1969, avatar: (UIImage(named: "girl_1")!), photosLibrary: girlsPhotos),
    User(nickname: "Велелый Кабанчик", name: "Виктор", familyName: "Кабанов", emailAddress: "victor.kabanov@geekbrains.ru", dayOfBorn: 23, monthOfBorn: 12, yearOfBorn: 1976, avatar: (UIImage(named: "boar")!), photosLibrary: boarsPhotos),
    User(nickname: "Удивленная Сова", name: "Антонина", familyName: "Совина", emailAddress: "antonina.sovina@geekbrains.ru", dayOfBorn: 24, monthOfBorn: 05, yearOfBorn: 1991, avatar: (UIImage(named: "owl")!), photosLibrary: owlsPhotos),
    User(nickname: "Грустная Обезьянка", name: "Эльвира", familyName: "Мартышкина", emailAddress: "elvira.martyshkina@geekbrains.ru", dayOfBorn: 7, monthOfBorn: 09, yearOfBorn: 1983, avatar: (UIImage(named: "monkey")!), photosLibrary: monkeysPhotos),
    User(nickname: "Робот Под Напряжением", name: "Геннадий", familyName: "Роботов", emailAddress: "gennadiy.robotov@geekbrains.ru", dayOfBorn: 17, monthOfBorn: 10, yearOfBorn: 1979, avatar: (UIImage(named: "robot")!), photosLibrary: robotsPhotos),
    User(nickname: "Гуманоид В Шоке", name: "Алексей", familyName: "Внеземной", emailAddress: "alexey.vnezemnoy@geekbrains.ru", dayOfBorn: 29, monthOfBorn: 02, yearOfBorn: 1952, avatar: (UIImage(named: "humanoid")!), photosLibrary: humanoidsPhotos),
    User(nickname: "Апатичная Какашка", name: "Альфред", familyName: "Запахов", emailAddress: "alfred.zapahov@geekbrains.ru", dayOfBorn: 31, monthOfBorn: 07, yearOfBorn: 1981, avatar: (UIImage(named: "piece_of_shit")!), photosLibrary: piecesPhotos),
    User(nickname: "Злобный Свинтус", name: "Григорий", familyName: "Поросенкин", emailAddress: "grigory.porosenkin@geekbrains.ru", dayOfBorn: 13, monthOfBorn: 01, yearOfBorn: 1995, avatar: (UIImage(named: "pig")!), photosLibrary: pigsPhotos),
    User(nickname: "Сонная Панда", name: "Юля", familyName: "Медведева", emailAddress: "julia.medvedeva@geekbrains.ru", dayOfBorn: 26, monthOfBorn: 03, yearOfBorn: 1986, avatar: (UIImage(named: "panda")!), photosLibrary: pandasPhotos),
    User(nickname: "Выносящий Дракон", name: "Сергей", familyName: "Мозгов", emailAddress: "sergey.mozgov@geekbrains.ru", dayOfBorn: 14, monthOfBorn: 11, yearOfBorn: 1974, avatar: (UIImage(named: "dragon")!), photosLibrary: dragonsPhotos),
    User(nickname: "Милая Коала", name: "Елена", familyName: "Запонкина", emailAddress: "elena.zaponkina@geekbrains.ru", dayOfBorn: 18, monthOfBorn: 08, yearOfBorn: 1990, avatar: (UIImage(named: "koala")!), photosLibrary: koalasPhotos)
]

//var listOfUsersDemo = listOfUsers.sorted()



let dragon_description = "Драко́н (греч. δράκων) — собирательное название, объединяющее ряд мифологических и фантастических существ. Дракон связан с христианским культом святого Георгия и получил широкое распространение в европейском религиозном искусстве. Традиции Восточной Азии также содержат немало драконообразных персонажей, таких как японский рю (竜), китайский лун (龍), вьетнамский лонг (龍), корейский ён (용) и др.В XX и XXI веках интерес к дракону усилился и продолжает усиливаться. По утверждению В. Н. Дёмина, «идёт драконий бум», у фантастических жанров любых форм — картины, книги, кинематограф, интернет-сайты и компьютерные игры имеют огромное количество поклонников[1]. Дракон нашёл широкое распространение в фэнтези, а также используется в фэншуй и астрологии (год дракона)."

var groupsDemo: [Group] = [
    Group(name: "Сообщество девочек", owner: listOfUsers[0], avatar: UIImage(named: "girls")!),
    Group(name: "Сообщество кабанчиков", owner: listOfUsers[1], avatar: UIImage(named: "boars")!),
    Group(name: "Сообщество сов", owner: listOfUsers[2], avatar: UIImage(named: "owls")!),
    Group(name: "Сообщество обезьян", owner: listOfUsers[3], avatar: UIImage(named: "monkeys")!),
    Group(name: "Сообщество роботов", owner: listOfUsers[4], avatar: UIImage(named: "robots")!),
    Group(name: "Сообщество гуманоидов", owner: listOfUsers[5], avatar: UIImage(named: "humanoids")!),
    Group(name: "Сообщество какашек", owner: listOfUsers[6], avatar: UIImage(named: "pieces_of_shit")!),
    Group(name: "Сообщество свинтусов", owner: listOfUsers[7], avatar: UIImage(named: "pigs")!),
    Group(name: "Сообщество панд", owner: listOfUsers[8], avatar: UIImage(named: "pandas")!),
    Group(name: "Сообщество драконов", owner: listOfUsers[9], avatar: UIImage(named: "dragons")!, description: dragon_description),
    Group(name: "Сообщество коал", owner: listOfUsers[10], avatar: UIImage(named: "koalas")!)
]

var demoUserMemberOf: [Group] = [groupsDemo[6], groupsDemo[8], groupsDemo[9]]

var demoUser = User(nickname: "lomax45", password: "password", name: "Максим", familyName: "Лосев", emailAddress: "maxim.losev@geekbrains.ru", dayOfBorn: 02, monthOfBorn: 06, yearOfBorn: 1988, avatar: (UIImage(named: "avatar"))!, memberOf: demoUserMemberOf)

//var currentUser:User = demoUser

var demoNews: [News] = [
    News(owner: randomUser(),
         creationDate: randomDate(),
         body: "Amazon официально представил сериал по «Властелину колец». В раме демонстрируется Вторая эпоха истории Средиземья. Как сообщает ToDay News Ufa, действия сюжета описывают времена, которые происходили до появления «Хоббита» и «Властелина колец».",
         pictures: [UIImage(named: "news0_img1")!],
         comments: ["Кинцо отпад", "Еще не смотрел", "А сколько собрал в кинотеатрах?"],
         likedBy: [demoUser]),
    News(owner: randomUser(),
         creationDate: randomDate(),
         body: "Фильм британского режиссера Гая Ричи «Джентльмены» стал самой популярной картиной по версии пользователей «Кинопоиск HD». Криминальная комедия вышла в кинотеатрах в феврале 2020 года, позднее она появилась на платформе «КиноПоиска». Фильм британского режиссера Гая Ричи «Джентльмены» стал самой популярной картиной по версии пользователей «Кинопоиск HD». Криминальная комедия вышла в кинотеатрах в феврале 2020 года, позднее она появилась на платформе «КиноПоиска».",
         pictures: [UIImage(named: "news1_img1")!, UIImage(named: "news1_img2")!, UIImage(named: "news1_img3")!, UIImage(named: "news1_img4")!],
         comments: ["Кинцо отпад", "Еще не смотрел", "А сколько собрал в кинотеатрах?"],
         likedBy: []),
    News(owner: randomUser(),
         creationDate: randomDate(),
         body: "Представители сети «Москино» назвали самые популярные фильмы в кинотеатрах на новогодних праздниках. Фильм «Последний богатырь: Корень зла» посетили около 16 тысяч человек. Ранее сообщалось, что сиквел «Последнего богатыря» заработал в прокате более миллиарда рублей.",
         pictures: [UIImage(named: "news2_img1")!, UIImage(named: "news2_img2")!],
         comments: ["Кинцо отпад", "Еще не смотрел", "А сколько собрал в кинотеатрах?"],
         likedBy: [])
]

private func randomUser() -> User {
    return listOfUsers[Int.random(in: 0..<listOfUsers.count)]
}

private func randomDate() -> String {
    let randomDate = NSDate(timeInterval: TimeInterval(Int.random(in: -3600*24..<0)), since: .init())
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy 'в' HH:mm"
    let date = formatter.string(from: randomDate as Date)
    return date
}
