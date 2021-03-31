//
//  BackGroundAvatarView.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 18.12.2020.
//

import UIKit

@IBDesignable class BackGroundAvatarView: UIView {
    
    @IBInspectable var shadowColor:UIColor = UIColor.black
    @IBInspectable var shadowRadius:CGFloat = 5
    @IBInspectable var shadowOpacity:Float = 1
        
    override func draw(_ rect: CGRect) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }

}
