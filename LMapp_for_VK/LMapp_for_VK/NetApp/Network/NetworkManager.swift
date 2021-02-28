//
//  NetworkManager.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 01.02.2021.
//

import Foundation
import WebKit
import UIKit

//Создаем перечисление, чтобы не вводить методы вручную
enum ApiMethods: String {
    case getFriends = "/method/friends.get"
    case getPhotos = "/method/photos.getAll"
    case getGroupsList = "/method/groups.get"
    case searchGroups = "/method/groups.search"
    case getUsers = "/method/users.get"
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
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.126")
        ]
        guard let url = urlAuthorize.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    //Фукция создания шаблона URL
    private func createApiUrlTemplate(method: ApiMethods) -> URLComponents {
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
    
    //Функция получения данных в зависимости от метода
    func getData(method: ApiMethods, compltionHandler: @escaping ([UserVK]) -> ()) {
        //создаем URL для указанного метода
        var url:URL? = nil
        switch method {
        case .getFriends:
            var getFriendsConstructor = createApiUrlTemplate(method: method)
            getFriendsConstructor.queryItems?.insert(URLQueryItem(name: "user_id", value: "457116142"), at: 0)
            getFriendsConstructor.queryItems?.insert(URLQueryItem(name: "count", value: "50"), at: 1)
            getFriendsConstructor.queryItems?.insert(URLQueryItem(name: "fields", value: "photo_50"), at: 2)
            url = getFriendsConstructor.url
            if url != nil {
                let session = URLSession.shared
                let task = session.dataTask(with: url!) { (data, response, error) in
                    if data != nil {
                        do {
                            let response = try JSONDecoder().decode(FriendsResponse.self, from: data!).response.items
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
        case .getPhotos:
            return
        case .getGroupsList:
            var getGroupsListConstructor = createApiUrlTemplate(method: method)
            getGroupsListConstructor.queryItems?.insert(URLQueryItem(name: "user_id", value: "\(NetSession.instance.userId)"), at: 0)
            getGroupsListConstructor.queryItems?.insert(URLQueryItem(name: "extended", value: "1"), at: 1)
            url = getGroupsListConstructor.url
        case .searchGroups:
            var searchGroupsConstructor = createApiUrlTemplate(method: method)
            searchGroupsConstructor.queryItems?.insert(URLQueryItem(name: "q", value: searchText), at: 0)
            searchGroupsConstructor.queryItems?.insert(URLQueryItem(name: "type", value: "group"), at: 1)
            searchGroupsConstructor.queryItems?.insert(URLQueryItem(name: "count", value: "5"), at: 2)
            url = searchGroupsConstructor.url
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
        }
    }
    
    func getData(method: ApiMethods, id: Int, compltionHandler: @escaping (ItemsPhoto) -> ()) {
        
        //создаем URL для указанного метода
        var url:URL? = nil
        switch method {
        case .getFriends:
            return
        case .getPhotos:
            var getPhotosConstructor = createApiUrlTemplate(method: method)
            getPhotosConstructor.queryItems?.insert(URLQueryItem(name: "owner_id", value: String(id)), at: 0)
            url = getPhotosConstructor.url
            print(getPhotosConstructor)
            
            if url != nil {
                let session = URLSession.shared
                let task = session.dataTask(with: url!) { (data, response, error) in
                    if data != nil {
                        do {
                            let response = try JSONDecoder().decode(PhotosResponse.self, from: data!).response
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
        case .getGroupsList:
            return
        case .searchGroups:
            return
        case .getUsers:
            return
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
    
}
