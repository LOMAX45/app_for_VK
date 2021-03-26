//
//  StartNetworkController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 01.02.2021.
//

import UIKit
import WebKit

class StartNetworkController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!{
        didSet{
            webview.navigationDelegate = self
        }
    }
    
    var friends:[UserVK] = []
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager.authorize(webview)
        
    }
    
    private func getCurrentUser(toVC: String) {
        networkManager.getData(method: .getUsers) { (users) in
            NetSession.instance.currentUser = users[0]
            guard let url = NetSession.instance.currentUser?.avatar else { return }
            self.networkManager.getImage(by: url) { (avatar) in
                NetSession.instance.avatar = avatar
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: toVC)
        show(controller, sender: nil)
        
    }
    
    private func getFriends() {
        networkManager.getData(method: .getFriends) { (friends) in
            self.friends = friends
            let friendsDb = UsersDB()
            self.friends.forEach({ friendsDb.write($0.toUserVkDb()) })
        }
    }
    
    private func getFriendsPhoto() {
        
        let friendsDb = UsersDB()
        let friends: [UserVkDb] = friendsDb.read() ?? []
        
        for friend in friends {
            
            if friend.id != 0 {
                
                let itemsPhoto = ItemsPhotoDb(ownerId: friend.id)
                let item = itemsPhoto.items
                let sizes = SizesDb(ownerId: friend.id)
                let size = sizes.sizes
                
                networkManager.getData(method: .getPhotos, id: friend.id) { (response) in
                    response.items.forEach({
                        for i in 0..<$0.sizes.count {
                            let properties = PhotoPropertiesDb(type: $0.sizes[i].type, url: $0.sizes[i].url, photoId: $0.id)
                            size.append(properties)
                        }
                        item.append(sizes)
                    })
                    DispatchQueue.main.async {
                        friendsDb.write(itemsPhoto)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    private func getGroups() {
        networkManager.getGroups(method: .getGroupsList) { (groups) in
            groups.items.forEach({
                let groupProperty = GroupPropertiesDb(id: $0.id, name: $0.name, screenName: $0.screenName, photo50: $0.photo50)
                DispatchQueue.main.async {
                    UsersDB().write(groupProperty)
                }
            })
        }
    }
    
    private func getNews() {
        print("START FUNCTION")
        self.networkManager.getNews(method: .getNews) { (news) in
            NewsDatabase.shared.items = news.items
            NewsDatabase.shared.profiles = news.profiles
            NewsDatabase.shared.groups = news.groups
        }
    }
    

    
}

extension StartNetworkController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"] else { return }
        guard let userId = params["user_id"] else { return }
        NetSession.instance.token = token
        NetSession.instance.userId = Int(userId) ?? 0
        
        print("USER IS IS \(NetSession.instance.userId)")
        print("TOKEN=\(NetSession.instance.token)")
        
        getNews()
        getFriends()
        getFriendsPhoto()
        getGroups()
        getCurrentUser(toVC: "LoggedOnController")
        
        decisionHandler(.cancel)
        
    }
}
