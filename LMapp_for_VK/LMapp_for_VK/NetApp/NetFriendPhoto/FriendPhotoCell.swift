//
//  FriendPhotoCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 19.02.2021.
//

import UIKit

class FriendPhotoCell: UICollectionViewCell {
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var friendPhoto: UIImageView!
    
//    func setData(image: UIImage) {
//        self.friendPhoto.image = image
//    }
//    
//    func setData (urlStr: String) {
//        networkManager.getImage(by: urlStr) { (image) in
//            DispatchQueue.main.async {
//                if let image = image as UIImage? {
//                    self.friendPhoto.image = image
//                }
//            }
//        }
//    }
    
    func addLikeControl() {
        let like = LikeControl(frame: CGRect(x: self.frame.size.width - 40, y: self.frame.size.height - 30, width: 38, height: 28))
        self.addSubview(like)
    }
}
