//
//  NetNewsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.03.2021.
//

import UIKit

class NetNewsController: UIViewController {
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = NewsDatabase.shared.items
    var profiles = NewsDatabase.shared.profiles
    var groups = NewsDatabase.shared.groups
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NetNewsPostCell", bundle: nil), forCellReuseIdentifier: "NetNewsPostCell")
        
        print("====================================")
        print("NEWS")
        print(NewsDatabase.shared.items)
        
        print("====================================")
        print("PROFILES")
        print(NewsDatabase.shared.profiles)


        
        print("====================================")
        print("GROUPS")
        print(NewsDatabase.shared.groups)
        print("====================================")
        
        items = NewsDatabase.shared.items
        profiles = NewsDatabase.shared.profiles
        groups = NewsDatabase.shared.groups
        
        tableView.reloadData()
        
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
