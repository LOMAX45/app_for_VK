////
////  FriendsListCell.swift
////  LMapp_for_VK
////
////  Created by Максим Лосев on 11.12.2020.
////
//
//import UIKit
//
//class FriendsListCell: UITableViewCell {
//
//    @IBOutlet weak var backGroundView: BackGroundAvatarView!
//    @IBOutlet weak var avatarImage: UIImageView! {
//        didSet {
//            layer.cornerRadius = 28
//            
//            let recognizer = UITapGestureRecognizer(target: self, action: #selector(animAvatar(_:)))
//            avatarImage.addGestureRecognizer(recognizer)
//            
//        }
//    }
//    
//    
//    @IBOutlet weak var nickLabel: UILabel!
//    @IBOutlet weak var infoLabel: UILabel!
//    
//    func setData (nick: String, info: String, avatar: UIImage) {
//        nickLabel.text = nick
//        infoLabel.text = info
//        avatarImage.image = avatar
//    }
//    
//    @objc func animAvatar(_ sender: UITapGestureRecognizer) {
//        
//        let animation = CASpringAnimation(keyPath: "transform.scale")
//        animation.fromValue = 0.75
//        animation.toValue = 1
//        animation.stiffness = 200
//        animation.mass = 2
//        animation.duration = 2
//        animation.fillMode = CAMediaTimingFillMode.backwards
//        
//        self.avatarImage.layer.add(animation, forKey: "transform.scale")
//        
//    }
//    
//}
