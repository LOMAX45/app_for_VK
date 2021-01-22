//
//  FriendsListController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

class FriendsListController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sections: [String : [User]] = [:]
    var keys: [String] = []
    
    func resetData() {
        sections = [:]
        keys = []
    }
    
    func sort(array: [User]) {
        array.forEach { user in
            let firstletter = String(user.nickname.first!)
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        sort(array: listOfUsers)
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.layer.bounds.width, height: 32))
        let textLabel = UILabel(frame: CGRect(x: 32, y: 0, width: tableView.layer.bounds.width - 64, height: 32))
        headerView.addSubview(textLabel)
        headerView.backgroundColor = UIColor.systemGray6
        headerView.layer.opacity = 0.5
        textLabel.text = keys[section]
        return headerView
    }
    //
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return keys[section]
    //    }
    
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            
            resetData()
            
            var foundedUsers:[User] = []
            listOfUsers.forEach { user in
                if (user.nickname).lowercased().contains(searchText.lowercased()) {
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
        sort(array: listOfUsers)
        tableView.reloadData()
    }
    
    
}
