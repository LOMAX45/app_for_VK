//
//  CurrentUserView.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 14.12.2020.
//

import UIKit

class CurrentUserView: UIView {
    
    @IBOutlet weak var currentUserAvatar: UIImageView! {
        didSet {
            currentUserAvatar.layer.cornerRadius = 14
            currentUserAvatar.image = Session.instance.currentUser.avatar
        }
    }

    
    @IBOutlet weak var currentUserName: UILabel! {
        didSet {
            currentUserName.text = Session.instance.currentUser.name
        }
    }

}
