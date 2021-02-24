//
//  FriendListController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.02.2021.
//

import UIKit

class FriendsListController: UIViewController {
    
    let networkManager = NetworkManager()
    var friends = UsersDB().read() ?? []
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sections: [String : [UserVkDb]] = [:]
    var keys: [String] = []
    
    func resetData() {
        sections = [:]
        keys = []
    }
    
    func sort(array: [UserVkDb]) {
        array.forEach { user in
            let firstletter = String(user.firstName.first!)
            if sections[firstletter] != nil {
                sections[firstletter]?.append(user)
            } else {
                sections[firstletter] = [user]
            }
        }
        keys = Array(sections.keys).sorted(by: <)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sort(array: friends)
        tableView.reloadData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showPhoto" {
                if let indexPath = tableView.indexPathForSelectedRow {
//                    let networkManager = NetworkManager()
                    let key = keys[indexPath.section]
                    let user = sections[key]![indexPath.row]
                    let id = user.id
                    networkManager.getData(method: .getPhotos, id: id) { (photos) in
                        let photosLibrary = photos
                        let friendPhotoController = segue.destination as! FriendPhotoController
                        friendPhotoController.photosLibrary = photosLibrary
                        DispatchQueue.main.async {
                            friendPhotoController.collectionView.reloadData()
                        }
                    }
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.layer.bounds.width, height: 32))
        let textLabel = UILabel(frame: CGRect(x: 32, y: 0, width: tableView.layer.bounds.width - 64, height: 32))
        headerView.addSubview(textLabel)
        headerView.backgroundColor = UIColor.systemGray6
        headerView.layer.opacity = 0.5
        textLabel.text = keys[section]
        return headerView
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
        
        let nick = user.firstName
        let info = "\(user.firstName) \(user.lastName)"
        let avatarUrl = user.avatar
        
        cell.setData(nick: nick, info: info, avatar: avatarUrl)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension FriendsListController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            
            resetData()
            
            var foundedUsers:[UserVkDb] = []
            friends.forEach { user in
                if (user.firstName).lowercased().contains(searchText.lowercased()) {
                    foundedUsers.append(user)
                }
            }
            
            sort(array: foundedUsers)
            
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
        resetData()
        sort(array: friends)
        tableView.reloadData()
    }
    
    
}

