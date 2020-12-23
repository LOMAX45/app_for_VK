//
//  GroupsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

class GroupsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let typeOfCell = "groupsCell"
    let typeOfCell = "templateGroupCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TemplateGroupCell", bundle: nil), forCellReuseIdentifier: "templateGroupCell")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsDemo.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if typeOfCell == "groupsCell" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as! GroupsCell
                cell.setData(name: groupsDemo[indexPath.row].name, avatar: groupsDemo[indexPath.row].avatar)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "templateGroupCell") as! TemplateGroupCell
                
                let index = indexPath.row
                
                cell.setData(name: groupsDemo[index].name, avatar: groupsDemo[index].avatar)
                return cell
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if typeOfCell == "templateGroupCell" {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(identifier: "UserGroupsController") as! UserGroupsController
            
            let index = indexPath.row
            let group = groupsDemo[index]
            if  currentUser.memberOf.contains(group) {
                alerting(viewController: self, title: "", message: "Вы уже состоите в сообществе")
            } else {
                currentUser.memberOf.append(group)
                controller.checkReload = true
                show(controller, sender: nil)
            }
            
        }
        
    }

}
