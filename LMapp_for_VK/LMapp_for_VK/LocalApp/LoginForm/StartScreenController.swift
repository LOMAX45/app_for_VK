//
//  StartScreenController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 14.12.2020.
//

import UIKit

class StartScreenController: UIViewController {
    
    @IBOutlet weak var regButtonStartScreen: UIButton! {
        didSet {
            regButtonStartScreen.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var logOnButtonStartScreen: UIButton!  {
        didSet {
            logOnButtonStartScreen.layer.cornerRadius = 10
        }
    }
    
    @IBAction func unwindSegue(sender: UIStoryboardSegue) {}
    
    @IBAction func signOut(segue: UIStoryboardSegue) {
        if segue.identifier == "signOut" && Session.instance.currentUser.nickname != "admin" {
            listOfUsers.append(Session.instance.currentUser)
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfUsers.append(demoUser)
        
    }
}
