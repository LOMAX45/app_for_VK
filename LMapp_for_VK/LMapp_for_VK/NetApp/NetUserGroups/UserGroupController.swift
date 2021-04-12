//
//  UserGroupController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 23.03.2021.
//

import UIKit
import PromiseKit
import SwiftyJSON

class UserGroupController: UIViewController {
    
    let networkManager = NetworkManager()
    let database = UsersDB()
    var userGroups:[GroupPropertiesDb] = []
    var photoService: PhotoService?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstly {
            networkManager.getGroupsAlamofire()
        }.then { (json) in
            self.promiseParser(json)
        }.done(on: .main) { (groups) in
            self.convertToDB(groups: groups)
            self.reloadTable()
        }.catch { (error) in
            print(error.localizedDescription)
        }
        tableView.dataSource = self
        tableView.delegate = self
        photoService = PhotoService(container: tableView)
    }
    
    private func convertToDB (groups: [GroupProperties]) {
        for group in groups {
            let groupProperty = GroupPropertiesDb(id: group.id, name: group.name, screenName: group.screenName, photo50: group.photo50)
            self.database.write(groupProperty)
        }
    }
    
    private func promiseParser(_ data: JSON) -> Promise<[GroupProperties]> {
        let promise = Promise<[GroupProperties]> { resolver in
            let groups = data["response"]["items"].arrayValue.map { GroupProperties(id: $0["id"].intValue, name: $0["name"].stringValue, screenName: $0["screen_name"].stringValue, photo50: $0["photo_50"].stringValue) }
            resolver.fulfill(groups)
        }
        return promise
    }
    
    private func reloadTable() {
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
        cell.setData(name: userGroups[indexPath.row].name)
        cell.backGroungView.setImage(((photoService?.photo(atIndexpath: indexPath, byUrl: userGroups[indexPath.row].photo50)) ?? UIImage(named: "robot"))!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
