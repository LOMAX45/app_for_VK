//
//  AvatarView.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 17.12.2020.
//

import UIKit

class AvatarView: UIView {
    
    var shadowColor:UIColor = .black
    var shadowOpacity:Float = 1
    var shadowRadius: CGFloat = 5
    
    var imageView: UIImageView? = nil
    
    func setImage(_ image: UIImage) {
        imageView = UIImageView(frame: self.bounds)
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = image
        imageView?.layer.cornerRadius = self.frame.size.height/2
        imageView?.layer.masksToBounds = true
        
        self.backgroundColor = .clear
        
        imageView?.isUserInteractionEnabled = true
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(animAvatar(_:)))
        imageView!.addGestureRecognizer(recognizer)
        
        self.addSubview(imageView!)
    }
    
    @objc func animAvatar(_ sender: UITapGestureRecognizer) {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.75
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.imageView!.layer.add(animation, forKey: "transform.scale")
        
    }
    
    
    override func draw(_ rect: CGRect) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }


}
