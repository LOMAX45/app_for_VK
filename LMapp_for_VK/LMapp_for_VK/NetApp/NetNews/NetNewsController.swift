//
//  NetNewsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.03.2021.
//

import UIKit

class NetNewsController: UIViewController {
    
     @IBOutlet weak var tableView: UITableView!

    let networkManager = NetworkManager()
    var items:[NewsItem] = []
    var profiles:[UserVK] = []
    var groups:[GroupProperties] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NetNewsPostCell", bundle: nil), forCellReuseIdentifier: "NetNewsPostCell")
        getNews()
        
    }
    
    private func loadingView () {
        let loadingView = ThreeDotLoadingIndicator(frame: CGRect(x: self.view.layer.bounds.width / 2 - 20, y: self.view.layer.bounds.height / 2 - 5, width: 40, height: 10))
        loadingView.startAnimation()
        self.view.addSubview(loadingView)
    }
    
    private func getNews() {
        let dispatchGroup = DispatchGroup()
        DispatchQueue.global().async(group: dispatchGroup) {
            self.networkManager.getNews(method: .getNews, type: .post) { (news) in
                NewsDatabase.shared.items = news.items
                NewsDatabase.shared.profiles = news.profiles
                NewsDatabase.shared.groups = news.groups
            }
        }
        sleep(5)
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.items = NewsDatabase.shared.items
            self.profiles = NewsDatabase.shared.profiles
            self.groups = NewsDatabase.shared.groups
            self.tableView.reloadData()
        }
    }
}

extension NetNewsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NetNewsPostCell", for: indexPath) as! NetNewsPostCell
        
        let item = items[indexPath.row]
        var ownerAvatar:String = ""
        var ownerNickname:String = ""
        
        if item.sourceId > 0 {
            var owner:UserVK?
            owner = profiles.first(where: { (profile) -> Bool in
                return profile.id == item.sourceId
            })
            if owner != nil {
                ownerAvatar = owner!.avatar
                ownerNickname = "\(owner!.firstName) \(owner!.lastName)"
            }
        } else {
            var owner:GroupProperties?
            owner = groups.first(where: { (group) -> Bool in
                return group.id == abs(item.sourceId)
            })
            if owner != nil {
                ownerAvatar = owner!.photo50
                ownerNickname = owner!.name
            }
        }
        
        cell.setData(ownerAvatar: ownerAvatar,
                     ownerNickname: ownerNickname,
                     creationDate: item.date,
                     bodyText: item.text,
                     numbersOfLikes: item.likes.count,
                     numbersOfComments: item.comments.count,
                     numbersOfReposts: item.reposts.count,
                     numbersOfViews: item.views.count)
        
        return cell
    }
    
}

