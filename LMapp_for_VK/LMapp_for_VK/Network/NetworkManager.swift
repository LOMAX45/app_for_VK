//
//  NetworkManager.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 01.02.2021.
//

import Foundation
import WebKit

//Создаем перечисление, чтобы не вводить методы вручную
enum ApiMethods: String {
    case getFriends = "/method/users.get"
    case getPhotos = "/method/photos.getAll"
    case getGroupsList = "/method/groups.get"
    case searchGroups = "/method/groups.search"
    
}

class NetworkManager {
    
    var searchText: String = ""
    
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
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.126")
        ]
        
        return urlApi
    }
    
    //Фукция получения данных в зависимости от метода
    func getData(method: ApiMethods, compltionHandler: @escaping (Any) -> ()) {
        //создаем URL для указанного метода
        var url:URL? = nil
        switch method {
        case .getFriends:
            var getFriendsConstructor = createApiUrlTemplate(method: method)
            getFriendsConstructor.queryItems?.insert(URLQueryItem(name: "fields", value: "nickname, sex, bdate, city, country"), at: 0)
            url = getFriendsConstructor.url
        case .getPhotos:
            var getPhotosConstructor = createApiUrlTemplate(method: method)
            getPhotosConstructor.queryItems?.insert(URLQueryItem(name: "owner_id", value: "\(Session.instance.userId)"), at: 0)
            getPhotosConstructor.queryItems?.insert(URLQueryItem(name: "album_id", value: "profile"), at: 1)
            url = getPhotosConstructor.url
        case .getGroupsList:
            var getGroupsListConstructor = createApiUrlTemplate(method: method)
            getGroupsListConstructor.queryItems?.insert(URLQueryItem(name: "user_id", value: "\(Session.instance.userId)"), at: 0)
            getGroupsListConstructor.queryItems?.insert(URLQueryItem(name: "extended", value: "1"), at: 1)
            url = getGroupsListConstructor.url
        case .searchGroups:
            var searchGroupsConstructor = createApiUrlTemplate(method: method)
            searchGroupsConstructor.queryItems?.insert(URLQueryItem(name: "q", value: searchText), at: 0)
            searchGroupsConstructor.queryItems?.insert(URLQueryItem(name: "type", value: "group"), at: 1)
            searchGroupsConstructor.queryItems?.insert(URLQueryItem(name: "count", value: "5"), at: 1)
            url = searchGroupsConstructor.url
        }
        
        if url != nil {
            let session = URLSession.shared
            let task = session.dataTask(with: url!) { (data, response, error) in
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    compltionHandler(json)
                } catch {
                    print(error.localizedDescription)
                }
                
                
            }
            task.resume()
        }
    }
    
    
}


