//
//  NetworkManager.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 01.02.2021.
//

import Foundation
import WebKit
import UIKit
import PromiseKit
import Alamofire
import SwiftyJSON

//Создаем перечисление, чтобы не вводить методы вручную
enum ApiMethods: String {
    case getFriends = "/method/friends.get"
    case getPhotos = "/method/photos.getAll"
    case getGroupsList = "/method/groups.get"
    case searchGroups = "/method/groups.search"
    case getUsers = "/method/users.get"
    case getNews = "/method/newsfeed.get"
}

enum ErrorMessages: Error {
    case somethingWentWrong(message: String)
}

class NetworkManager {
    
    var searchText: String = ""
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    //Фукция WEB авторизации из методички
    func authorize(_ webView: WKWebView) {
        var urlAuthorize = URLComponents()
        urlAuthorize.scheme = "https"
        urlAuthorize.host = "oauth.vk.com"
        urlAuthorize.path = "/authorize"
        urlAuthorize.queryItems = [
            URLQueryItem(name: "client_id", value: "7748029"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        guard let url = urlAuthorize.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    //Фукция создания шаблона URL
    func createApiUrlTemplate(method: ApiMethods) -> URLComponents {
        var urlApi = URLComponents()
        urlApi.scheme = "https"
        urlApi.host = "api.vk.com"
        urlApi.path = method.rawValue
        urlApi.queryItems = [
            URLQueryItem(name: "access_token", value: NetSession.instance.token),
            URLQueryItem(name: "v", value: "5.126")
        ]
        return urlApi
    }
    
    //Функции получения данных в зависимости от метода
    func getData(method: ApiMethods, compltionHandler: @escaping ([UserVK]) -> ()) {
        //создаем URL для указанного метода
        var url:URL? = nil
        switch method {
        case .getUsers:
            var getUserConstructor = createApiUrlTemplate(method: method)
            getUserConstructor.queryItems?.insert(URLQueryItem(name: "fields", value: "photo_50"), at: 0)
            url = getUserConstructor.url
            if url != nil {
                let session = URLSession.shared
                let task = session.dataTask(with: url!) { (data, response, error) in
                    if data != nil {
                        do {
                            let response = try JSONDecoder().decode(UsersResponse.self, from: data!).response
                            compltionHandler(response)
                        } catch {
                            print(error)
                        }
                    } else {
                        print("Data is nil")
                    }
                }
                task.resume()
            }
        default: return
        }
    }
    
    func getData(method: ApiMethods, id: Int, compltionHandler: @escaping (Response) -> ()) {
        
        //создаем URL для указанного метода
        switch method {
        case .getPhotos:
            var getPhotosConstructor = createApiUrlTemplate(method: method)
            getPhotosConstructor.queryItems?.insert(URLQueryItem(name: "owner_id", value: String(id)), at: 0)
            let url = getPhotosConstructor.url
            if url != nil {
                let session = URLSession.shared
                let task = session.dataTask(with: url!) { (data, response, error) in
                    if data != nil {
                        do {
                            let response = try JSONDecoder().decode(PhotosJson.self, from: data!).response
                            compltionHandler(response)
                        } catch {
                            print(error)
                        }
                    } else {
                        print("Data is nil")
                    }
                }
                task.resume()
            }
        default: return
        }
    }
    
    func getJson(method: ApiMethods, complitionHandler: @escaping (Data) -> ()) {
        switch method {
        case .getNews:
            var getNewsConstructor = createApiUrlTemplate(method: method)
            getNewsConstructor.queryItems?.insert(URLQueryItem(name: "filters", value: "post"), at: 0)
            getNewsConstructor.queryItems?.insert(URLQueryItem(name: "count", value: "100"), at: 1)
            let url = getNewsConstructor.url
            
            if url != nil {
                let session = URLSession.shared
                let task = session.dataTask(with: url!) { (data, response, error) in
                    if data != nil {
                        complitionHandler(data!)
                    } else {
                        print("Data is empty")
                    }
                }
                task.resume()
            }
        case .getFriends:
            var getFriendsConstructor = createApiUrlTemplate(method: method)
//            getFriendsConstructor.queryItems?.insert(URLQueryItem(name: "user_id", value: "457116142"), at: 0)
            getFriendsConstructor.queryItems?.insert(URLQueryItem(name: "count", value: "18"), at: 1)
            getFriendsConstructor.queryItems?.insert(URLQueryItem(name: "fields", value: "photo_50"), at: 2)
            let url = getFriendsConstructor.url
            if url != nil {
                let session = URLSession.shared
                let task = session.dataTask(with: url!) { (data, response, error) in
                    if data != nil {
                        complitionHandler(data!)
                    } else {
                        print("Data is empty")
                    }
                }
                task.resume()
            }
        default: return
        }
    }
    
    func getImage(by urlStr: String, compltionHandler: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            compltionHandler(imageFromCache)
        }
        
        if let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            imageCache.setObject(image!, forKey: url as AnyObject)
            compltionHandler(image!)
        }
    }
    
    func getGroupsAlamofire() -> Promise<[GroupProperties]> {
        var baseUrlConstructor = createApiUrlTemplate(method: .getGroupsList)
        baseUrlConstructor.queryItems?.insert(URLQueryItem(name: "extended", value: "1"), at: 0)
        let promise = Promise<[GroupProperties]> { resolver in
            AF.request(baseUrlConstructor, method: .get).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    if let errorMessage = json["message"].string {
                        let error = ErrorMessages.somethingWentWrong(message: errorMessage)
                        resolver.reject(error)
                        return
                    }
                    let groups = json["response"]["items"].arrayValue.map {
                        GroupProperties(id: $0["id"].intValue, name: $0["name"].stringValue, screenName: $0["screen_name"].stringValue, photo50: $0["photo_50"].stringValue)
                    }
                    resolver.fulfill(groups)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
    
}
