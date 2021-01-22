//
//  ThreeDotLoadingIndicator.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 14.01.2021.
//

import UIKit

class ThreeDotLoadingIndicator: UIView {
    
    var pointView1 = UIView()
    var pointView2 = UIView()
    var pointView3 = UIView()
    
    private func setPoint(view: UIView, positionX: CGFloat) {
        view.frame = CGRect(x: positionX, y: 0.0, width: 10, height: 10)
        view.layer.cornerRadius = pointView1.bounds.height / 2
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = .clear
    }

    func startAnimation() {
        
        setPoint(view: pointView1, positionX: 0.0)
        setPoint(view: pointView2, positionX: self.bounds.width / 2 - 5)
        setPoint(view: pointView3, positionX: self.bounds.width - 10)
        
        self.addSubview(pointView1)
        self.addSubview(pointView2)
        self.addSubview(pointView3)
            
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.pointView1.backgroundColor = UIColor.gray
        }, completion: nil)
            
        UIView.animate(withDuration: 1.0, delay: 0.33, options: [.repeat, .autoreverse], animations: {
            self.pointView2.backgroundColor = UIColor.gray
        }, completion: nil)

        UIView.animate(withDuration: 1.0, delay: 0.66, options: [.repeat, .autoreverse], animations: {
            self.pointView3.backgroundColor = UIColor.gray
        }, completion: nil)
        
    }

}
