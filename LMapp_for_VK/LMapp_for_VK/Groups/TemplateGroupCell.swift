//
//  TemplateGroupCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 22.12.2020.
//

import UIKit

class TemplateGroupCell: UITableViewCell {

    @IBOutlet weak var shadowView: BackGroundAvatarView!
    @IBOutlet weak var avatarLogo: UIImageView! {
        didSet {
            layer.cornerRadius = self.bounds.size.height / 2
        }
    }
    @IBOutlet weak var groupNameLabel: UILabel!
    
    func setData(name: String, avatar: UIImage) {
        groupNameLabel.text = name
        avatarLogo.image = avatar
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
