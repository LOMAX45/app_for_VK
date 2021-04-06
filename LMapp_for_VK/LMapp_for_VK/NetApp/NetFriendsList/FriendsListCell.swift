//
//  FriendsListCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.02.2021.
//

import UIKit

class FriendsListCell: UITableViewCell {
    
    let networkManager = NetworkManager()

    @IBOutlet weak var backGroundView: BackGroundAvatarView!
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            
            avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
            avatarImage.layer.masksToBounds = true
           
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(animAvatar(_:)))
            avatarImage.addGestureRecognizer(recognizer)
            
        }
    }
        
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func setData (nick: String, info: String, avatar: String) {
        nickLabel.text = nick
        infoLabel.text = info
        
        networkManager.getImage(by: avatar) { (image) in
            DispatchQueue.main.async {
                if let avatar = image as UIImage? {
                    self.avatarImage.image = avatar
                }
            }
        }
    }
    
    @objc func animAvatar(_ sender: UITapGestureRecognizer) {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.75
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.avatarImage.layer.add(animation, forKey: "transform.scale")
        
    }
    
}

