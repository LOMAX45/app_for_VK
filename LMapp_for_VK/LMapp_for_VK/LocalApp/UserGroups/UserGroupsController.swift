//
//  UserGroupsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

class UserGroupsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userGroupsDemo = Session.instance.currentUser.memberOf
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            
            if let groupController = segue.source as? GroupsController {
                if groupController.typeOfCell == "groupCell" {
                    if let indexPath = groupController.tableView.indexPathForSelectedRow {
                        let group = groupsDemo[indexPath.row]
                        if !userGroupsDemo.contains(group) {
                            userGroupsDemo.append(group)
                            tableView.reloadData()
                        } else {
                            alerting(viewController: self, title: "", message: "Вы уже состоите в сообществе")
                        }
                    }
                } else {
                    userGroupsDemo = Session.instance.currentUser.memberOf
                    tableView.reloadData()
                }
            } else if let groupInfoController = segue.source as? GroupInfoController {
                userGroupsDemo = Session.instance.currentUser.memberOf
                tableView.reloadData()
            } else {
                return
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroupsDemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroupsCell", for: indexPath) as! UserGroupsCell
        cell.setData(name: userGroupsDemo[indexPath.row].name, image: userGroupsDemo[indexPath.row].avatar)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroupsDemo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGroupInfo" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let group = userGroupsDemo[indexPath.row]
                let groupInfoController = segue.destination as! GroupInfoController
                groupInfoController.selectedGroup = group
            }
        }
    }
}