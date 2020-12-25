//
//  FriendsListController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

class FriendsListController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections: [String : [User]] = [:]
    var keys: [String] = []
    var filteredArray: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        listOfUsers.forEach { user in
            let firstletter = String(user.nickname.first!)
            if sections[firstletter] != nil {
                sections[firstletter]?.append(user)
            } else {
                sections[firstletter] = [user]
            }
        }
        keys = Array(sections.keys).sorted(by: <)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let photosLibrary = sections[keys[indexPath.section]]![indexPath.row].photosLibrary
                let friendPhotoController = segue.destination as! FriendPhotoController
                friendPhotoController.photosLibrary = photosLibrary
            }
        }
    }
    
}

extension FriendsListController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let count = sections[key]!.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsListCell") as! FriendsListCell
        
        let key = keys[indexPath.section]
        let user = sections[key]![indexPath.row]
        
        let avatar = user.avatar
        let nick = user.nickname
        let info = "\(user.name) \(user.familyName), Возраст: \(user.age)"
        
        cell.setData(nick: nick, info: info, avatar: avatar)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension FriendsListController: UISearchBarDelegate {
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        <#code#>
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         filteredArray = listOfUsers
        
        if searchText.isEmpty == false {
            filteredArray = filteredArray.filter({ $0.nickname.contains(searchText) })
        }
    }
}
