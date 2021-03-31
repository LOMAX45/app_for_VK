//
//  NewsLikeControl.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.12.2020.
//

//import UIKit
//
//class NewsLikeControl: UIControl {
//    
//    let index: Int
//    
//    private var button = UIButton(type: .custom)
//    private var quantity = UILabel(frame: CGRect(x: 48, y: 0, width: 30, height: 48))
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupView() {
//        button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
//        button.tintColor = .red
//        button.setImage(UIImage(systemName: "heart"), for: .normal)
//        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
//        button.addTarget(self, action: #selector(likeTapped(_:)), for: .touchUpInside)
//        
//        if demoNews[index].likedBy.contains(currentUser) {
//            button.isSelected = true
//        } else {
//            button.isSelected = false
//        }
//        
//        quantity.textColor = .red
//        quantity.textAlignment = .center
//        quantity.font = .systemFont(ofSize: 16)
//        quantity.text = ""
//        
//        self.addSubview(button)
//        self.addSubview(quantity)
//    }
//    
//    @objc private func likeTapped(_ sender: UIButton) {
//        if button.isSelected == true {
//            demoNews[index].likes -= 1
//            button.isSelected = false
//        } else {
//            button.isSelected = true
//            demoNews[index].likes -= 1
//        }
//        quantity.text = "\(demoNews[index].likes)"
//    }
//    
//}
