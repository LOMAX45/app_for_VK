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
        if segue.identifier == "signOut" && currentUser.nickname != "admin" {
            listOfUsers.append(currentUser)
        }
    }
    
    private func loadingAnimation() {
        
        let pointView1 = UIView.init(frame: (CGRect(x: (self.view.bounds.width / 2 - 20), y: (self.view.bounds.height * 0.75 - 5), width: 10, height: 10)))
        pointView1.layer.cornerRadius = pointView1.bounds.height / 2
        pointView1.layer.masksToBounds = true
        pointView1.backgroundColor = UIColor.gray
        
        let pointView2 = UIView.init(frame: (CGRect(x: (self.view.bounds.width / 2 - 5), y: (self.view.bounds.height * 0.75 - 5), width: 10, height: 10)))
        pointView2.layer.cornerRadius = pointView2.bounds.height / 2
        pointView2.layer.masksToBounds = true
        pointView2.backgroundColor = UIColor.gray
        
        let pointView3 = UIView.init(frame: (CGRect(x: (self.view.bounds.width / 2 + 10), y: (self.view.bounds.height * 0.75 - 5), width: 10, height: 10)))
        pointView3.layer.cornerRadius = pointView3.bounds.height / 2
        pointView3.layer.masksToBounds = true
        pointView3.backgroundColor = UIColor.gray
        
        self.view.addSubview(pointView1)
        self.view.addSubview(pointView2)
        self.view.addSubview(pointView3)
        
        
            
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                pointView1.alpha = 0.5
                pointView1.frame.origin.y += 1
        }, completion: nil)
            
        UIView.animate(withDuration: 0.5, delay: 0.25, options: [.repeat, .autoreverse], animations: {
            pointView2.alpha = 0.5
            pointView2.frame.origin.y += 1
        }, completion: nil)

        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.repeat, .autoreverse], animations: {
            pointView3.alpha = 0.5
            pointView3.frame.origin.y += 1
        }, completion: nil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfUsers.append(demoUser)
        
        loadingAnimation()
        
    }
}
