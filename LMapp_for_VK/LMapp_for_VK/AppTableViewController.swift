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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
 */

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
            let brake = tableForBreak.dequeueReusableCell(withIdentifier: "break")
            return brake!
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
