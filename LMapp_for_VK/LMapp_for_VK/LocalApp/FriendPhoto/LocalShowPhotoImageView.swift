////
////  ShowPhotoImageView.swift
////  LMapp_for_VK
////
////  Created by Максим Лосев on 13.01.2021.
////
//
//import UIKit
//
//class ShowPhotoImageView: UIView {
//    
//    var imageView: UIImageView!
//    
//    var initialCenter: CGPoint?
//    
//    var photosLibrary: [UIImage]!
//    var selectedPhoto: Int!
//    
//    func setImageView() {
//        imageView = UIImageView(frame: self.bounds)
//        imageView.backgroundColor = UIColor.systemGray2
//        imageView.image = photosLibrary[selectedPhoto]
//        self.addSubview(imageView)
//        
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeView(_:)))
//        swipeRight.direction = .right
//        self.imageView.addGestureRecognizer(swipeRight)
//        
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeView(_:)))
//        swipeLeft.direction = .left
//        self.imageView.addGestureRecognizer(swipeLeft)
//
//        imageView.isUserInteractionEnabled = true
//        
//    }
//    
//    private func swipeAnimate(_ direction: UISwipeGestureRecognizer.Direction) {
//        UIView.animateKeyframes(withDuration: 0.2,
//                                delay: 0.0,
//                                options: [],
//                                animations: {
//                                    UIView.addKeyframe(withRelativeStartTime: 0.0,
//                                                       relativeDuration: 0.3,
//                                                       animations: {
//                                                        self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//                                                       })
//                                    UIView.addKeyframe(withRelativeStartTime: 0.2,
//                                                       relativeDuration: 0.85,
//                                                       animations: {
//                                                        if direction == .left {
//                                                            self.imageView.center.x -= self.bounds.width
//                                                        } else {
//                                                        self.imageView.center.x += self.bounds.width
//                                                        }
//                                                       })
//                                },
//                                completion: {_ in
//                                    self.imageView.alpha = 0
//                                    self.imageView.center.x = self.center.x
//                                    if direction == .left {
//                                        self.selectedPhoto += 1
//                                    } else {
//                                        self.selectedPhoto -= 1
//                                    }
//                                    self.imageView.image = self.photosLibrary[self.selectedPhoto]
//                                    UIView.animateKeyframes(withDuration: 0.15,
//                                                            delay: 0.0,
//                                                            options: [],
//                                                            animations: {
//                                                                UIView.addKeyframe(withRelativeStartTime: 0.0,
//                                                                                   relativeDuration: 1.0,
//                                                                                   animations: {
//                                                                                    self.imageView.alpha = 1
//                                                                                   })
//                                                                UIView.addKeyframe(withRelativeStartTime: 0.3,
//                                                                                   relativeDuration: 0.3,
//                                                                                   animations: {
//                                                                                    self.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                                                                   })
//                                                            },
//                                                            completion: nil)
//                                    
//                                })
//    }
//    
//    private func lastSwipe(_ direction: UISwipeGestureRecognizer.Direction) {
//        
//        UIView.animateKeyframes(withDuration: 0.15,
//                                delay: 0.0,
//                                options: [],
//                                animations: {
//                                    if direction == .left {
//                                        self.imageView.center.x -= 50
//                                    } else {
//                                        self.imageView.center.x += 50
//                                    }
//                                },
//                                completion: {_ in
//                                    UIView.animate(withDuration: 0.15,
//                                                   delay: 0.0,
//                                                   usingSpringWithDamping: 0.5,
//                                                   initialSpringVelocity: 0.0,
//                                                   options: [],
//                                                   animations: {
//                                                    self.imageView.center.x = self.center.x
//                                                   },
//                                                   completion: nil)
//                                })
//        
//    }
//
//    
//    @objc func changeView(_ swipeGesture: UISwipeGestureRecognizer) {
//                switch swipeGesture.direction {
//                case .left:
//                    if selectedPhoto != photosLibrary.count - 1 {
//                        swipeAnimate(.left)
//                    } else {
//                        lastSwipe(.left)
//                    }
//                case .right:
//                    if selectedPhoto != 0 {
//                        swipeAnimate(.right)
//                    } else {
//                        lastSwipe(.right)
//                    }
//                default: break
//                }
//        }
//    
//}