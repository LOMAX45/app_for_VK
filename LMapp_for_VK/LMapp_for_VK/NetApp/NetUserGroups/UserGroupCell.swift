//
//  UserGroupCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 23.03.2021.
//

import UIKit

class UserGroupCell: UITableViewCell {

    let networkManager = NetworkManager()
    @IBOutlet weak var nameLabel: UILabel!
    
    let backGroungView = AvatarView(frame: CGRect(x: 8, y: 4, width: 56, height: 56))
    
    func setData (name: String, imageStr: String) {
        networkManager.getImage(by: imageStr) { (image) in
            DispatchQueue.main.async {
                if let logo = image as UIImage? {
                    self.backGroungView.setImage(logo)
                }
            }
        }
        self.addSubview(backGroungView)
        nameLabel.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = nil
        backGroungView.removeFromSuperview()

    }

}
