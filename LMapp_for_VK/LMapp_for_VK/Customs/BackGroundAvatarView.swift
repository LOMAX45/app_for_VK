//
//  BackGroundAvatarView.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.12.2020.
//

import UIKit

class BackGroundAvatarView: UIView {
        
    override func draw(_ rect: CGRect) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
    }

}
