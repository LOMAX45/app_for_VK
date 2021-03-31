//
//  NetFriendsListController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 17.02.2021.
//

import UIKit

class NetFriendsListController: UIViewController {
    @IBOutlet weak var currentUserAvatar: UIImageView! {
        didSet {
            currentUserAvatar.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var currentUserName: UILabel!
    
    @IBAction func switchToUrlController(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "UrlRequestsController")
        show(controller, sender: nil)
        
    }
    
    
    
    let networkManager = NetworkManager()
//    var currentUser:UserVK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getData(method: .getUsers) { (user) in
            NetSession.instance.currentUser = user as? UserVK
//            self.currentUser = NetSession.instance.currentUser
//            print(self.currentUser)
            
            guard let currentUser = NetSession.instance.currentUser, currentUser.firstName != "", currentUser.lastName != "" else { return }
            guard let imageURL = URL(string: currentUser.avatar), let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.currentUserName.text = "\(currentUser.firstName) \(currentUser.lastName)"
                self.currentUserAvatar.image = image
            }
            
            
        }

    }

}
