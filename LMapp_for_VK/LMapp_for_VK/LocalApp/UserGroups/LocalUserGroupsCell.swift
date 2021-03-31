////
////  UserGroupsCell.swift
////  LMapp_for_VK
////
////  Created by Максим Лосев on 13.12.2020.
////
//
//import UIKit
//
//class UserGroupsCell: UITableViewCell {
//    
////    @IBOutlet weak var avatarPicture: UIImageView! {
////        didSet {
////            avatarPicture.layer.cornerRadius = 28
////        }
////    }
//
////    @IBOutlet weak var backGroundView: BackGroundAvatarView!
//    
//    @IBOutlet weak var groupName: UILabel!
//    
//    let backGroungView = AvatarView(frame: CGRect(x: 8, y: 4, width: 56, height: 56))
//    
//    func setData (name: String, image: UIImage) {
//        backGroungView.setImage(image)
//        self.addSubview(backGroungView)
//        groupName.text = name
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        groupName.text = nil
//        backGroungView.removeFromSuperview()
//        
//    }
//
////    func setData (name: String, image: UIImage) {
////        avatarPicture.image = image
////        groupName.text = name
////    }
//
//}
