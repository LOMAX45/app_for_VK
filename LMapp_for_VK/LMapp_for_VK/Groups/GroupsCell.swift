//
//  GroupsCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

class GroupsCell: UITableViewCell {


    @IBOutlet weak var backGroundView: BackGroundAvatarView!
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            layer.cornerRadius = 28
        }
    }
    @IBOutlet weak var groupName: UILabel!

    
    func setData(name: String, avatar: UIImage) {
        groupName.text = name
        avatarImage.image = avatar
    }

}
