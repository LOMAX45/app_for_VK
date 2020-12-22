////
////  AvatarView.swift
////  LMapp_for_VK
////
////  Created by Максим Лосев on 17.12.2020.
////
//
//import UIKit
//
//@IBDesignable class AvatarView: UIView {
//    
//    @IBInspectable var shadowColor:UIColor = .black
//    @IBInspectable var shadowOpacity:Float = 1
//    @IBInspectable var shadowRadius: CGFloat = 5
//    
//    var imageView: UIImageView? = nil
//    
//    func setImage(_ image: UIImage) {
//        imageView = UIImageView(frame: self.bounds)
//        imageView?.contentMode = .scaleAspectFit
//        imageView?.image = image
//        imageView?.layer.cornerRadius = self.frame.size.height/2
//        imageView?.layer.masksToBounds = true
//        
//        self.backgroundColor = .clear
//        
//        self.addSubview(imageView!)
//    }
//    
//    
//    override func draw(_ rect: CGRect) {
//        layer.shadowColor = shadowColor.cgColor
//        layer.shadowOffset = .zero
//        layer.shadowRadius = shadowRadius
//        layer.shadowOpacity = shadowOpacity
//    }
//
//
//}
