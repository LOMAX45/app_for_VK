//
//  FriendsListController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

class FriendsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfUsersDemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsListCell", for: indexPath) as! FriendsListCell
        cell.setData(nick: listOfUsersDemo[indexPath.row].nickname, avatar: listOfUsersDemo[indexPath.row].avatar)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let photo = listOfUsersDemo[indexPath.row].avatar
                let friendPhotoController = segue.destination as! FriendPhotoController
                friendPhotoController.avatar.append(photo)
            }
        }
    }
}
