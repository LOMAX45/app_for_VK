//
//  AppTableViewController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 08.12.2020.
//

import UIKit

class AppTableViewController: UITableViewController {

    let friends = ["Самый лучший друг", "Лучший друг", "Не самый лучший друг", "Друг"]
    let groups = ["Группа 1", "Группа 2", "Группа 3", "Группа 4"]
    
    @IBOutlet var friendsTableView: UITableView!
    @IBOutlet var groupsTableView: UITableView!
    var tableForBreak: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case friendsTableView:
            return friends.count
        case groupsTableView:
            return groups.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case friendsTableView:
            let cell = friendsTableView.dequeueReusableCell(withIdentifier: "friendCellIdentifier", for: indexPath)
            cell.textLabel?.text = friends[indexPath.row]
            return cell
        case groupsTableView:
            let cell = groupsTableView.dequeueReusableCell(withIdentifier: "groupsCellIdentifier", for: indexPath)
            cell.textLabel?.text = groups[indexPath.row]
            return cell
        default:
            let cell = tableView.visibleCells[0]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case friendsTableView:
            friendsTableView.deselectRow(at: indexPath, animated: true)
        case groupsTableView:
            groupsTableView.deselectRow(at: indexPath, animated: true)
        default: break
        }
    }
}
