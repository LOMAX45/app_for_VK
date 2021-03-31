//
//  UserGroupController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 23.03.2021.
//

import UIKit

class UserGroupController: UIViewController {
    
    let networkManager = NetworkManager()
    let database = UsersDB()
    var userGroups:[GroupPropertiesDb] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        userGroups = database.read() ?? []
        
        if userGroups.count != 0 {
            tableView.reloadData()
        }

    }

}

extension UserGroupController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroupCell", for: indexPath) as! UserGroupCell
        cell.setData(name: userGroups[indexPath.row].name, imageStr: userGroups[indexPath.row].photo50)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
