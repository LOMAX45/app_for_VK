//
//  UserGroupsCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

class UserGroupsCell: UITableViewCell {
    @IBOutlet weak var avatarPicture: UIImageView! {
        didSet {
            avatarPicture.layer.cornerRadius = 28
        }
    }

    @IBOutlet weak var backGroundView: BackGroundAvatarView!
    
    @IBOutlet weak var groupName: UILabel!
    
    
    
    func setData (name: String, image: UIImage) {
        avatarPicture.image = image
        groupName.text = name
    }

}
