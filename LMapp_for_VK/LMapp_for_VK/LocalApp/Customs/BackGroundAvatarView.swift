//
//  BackGroundAvatarView.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.12.2020.
//

import UIKit

class BackGroundAvatarView: UIView {
    
    var shadowColor:UIColor = UIColor.black
    var shadowRadius:CGFloat = 5
    var shadowOpacity:Float = 1
        
    override func draw(_ rect: CGRect) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }

}
