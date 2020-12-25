//
//  GroupInfoController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 14.12.2020.
//

import UIKit

class GroupInfoController: UIViewController {
    
    var selectedGroup:Group!
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var ownerLabel: UILabel!
    
    
    private func addAddButton () {
        
        guard !currentUser.memberOf.contains(selectedGroup) else { return }
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .save , target: self, action: #selector(addGroup(_:)))
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .done, target: self, action: #selector(addGroup(_:)))

        self.navigationItem.setRightBarButton(addButton, animated: true)
        
    }
    
    @objc private func addGroup(_ sender: UIBarButtonItem) {
        currentUser.memberOf.append(selectedGroup)
        performSegue(withIdentifier: "addGroup", sender: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "UserGroupsController")
//        show(controller, sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImage.image = selectedGroup.avatar
        nameLabel.text = selectedGroup.name
        descriptionText.text = selectedGroup.description
        ownerLabel.text = "Владелец группы: \(selectedGroup.owner.nickname)"
        
        addAddButton()
        
    }
}
