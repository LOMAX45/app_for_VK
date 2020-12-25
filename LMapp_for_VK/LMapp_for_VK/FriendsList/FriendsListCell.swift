//
//  FriendsListCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

class FriendsListCell: UITableViewCell {

    @IBOutlet weak var backGroundView: BackGroundAvatarView!
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            layer.cornerRadius = 28
        }
    }
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func setData (nick: String, info: String, avatar: UIImage) {
        nickLabel.text = nick
        infoLabel.text = info
        avatarImage.image = avatar
    }
    
}
