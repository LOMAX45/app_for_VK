//
//  FriendPhotoCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

class FriendPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: UIImageView!
    
    func setData (image: UIImage) {
        friendPhoto.image = image
    }
}
