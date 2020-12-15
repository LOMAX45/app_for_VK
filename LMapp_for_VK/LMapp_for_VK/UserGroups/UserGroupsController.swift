//
//  UserGroupsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

class UserGroupsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userGroupsDemo = currentUser.memberOf
    
    @IBOutlet weak var tableView: UITableView!
    
    private func alerting (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let groupsController = segue.source as? GroupsController else {
                return
            }
            if let indexPath = groupsController.tableView.indexPathForSelectedRow {
                let group = groupsDemo[indexPath.row]
                if !userGroupsDemo.contains(group) {
                    userGroupsDemo.append(group)
                    tableView.reloadData()
                } else {
                    alerting(title: "", message: "Вы уже состоите в сообществе")
                }
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
                groupInfoController.selectedGroup.append(group)
            }
        }
    }
    
}
