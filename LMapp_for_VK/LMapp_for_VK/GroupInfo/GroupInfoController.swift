//
//  GroupInfoController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 14.12.2020.
//

import UIKit

class GroupInfoController: UIViewController {
    
    var selectedGroup:[Group] = []
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var ownerLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImage.image = selectedGroup[0].avatar
        nameLabel.text = selectedGroup[0].name
        descriptionText.text = selectedGroup[0].description
        ownerLabel.text = "Владелец группы: \(selectedGroup[0].owner.nickname)"
        
    }
}
