//
//  UserGroupController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 23.03.2021.
//

import UIKit
import PromiseKit

class UserGroupController: UIViewController {
    
    let networkManager = NetworkManager()
    let database = UsersDB()
    var userGroups:[GroupPropertiesDb] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getGroupsAlamofire()
            .done(on: .main) { [weak self] groups in
                guard let self = self else { return }
                self.convertToDB(groups: groups)
                self.userGroups = self.database.read() ?? []
                if self.userGroups.count != 0 {
                    self.tableView.reloadData()
                }
            }
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    private func convertToDB (groups: [GroupProperties]) {
        for group in groups {
            let groupProperty = GroupPropertiesDb(id: group.id, name: group.name, screenName: group.screenName, photo50: group.photo50)
            self.database.write(groupProperty)
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
