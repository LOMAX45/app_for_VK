//
//  GroupsCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 13.12.2020.
//

import UIKit

class GroupsCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var avatarPicture: UIImageView!
    
    func setData(name: String, avatar: UIImage) {
        groupName.text = name
        avatarPicture.image = avatar
    }

}
