//
//  FriendsListCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

class FriendsListCell: UITableViewCell {

    @IBOutlet weak var nickLabel: UILabel!
    
    func addAvatarView(avatar: UIImage) {
        let avatarView = AvatarView(frame: CGRect(x: 8, y: 4, width: 56, height: 56))
        avatarView.setImage(avatar)
        avatarView.tag = 1
        self.addSubview(avatarView)
    }
    
    func setLabel (nick: String) {
        nickLabel.text = nick
    }
    
    

}
