//
//  FriendsListCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

class FriendsListCell: UITableViewCell {

    @IBOutlet weak var avatarPicture: UIImageView! {
        didSet {
            avatarPicture.layer.cornerRadius = 29
            avatarPicture.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nickLabel: UILabel!
    
    func setData (nick: String, avatar: UIImage) {
        avatarPicture.image = avatar
        nickLabel.text = nick
    }

}
