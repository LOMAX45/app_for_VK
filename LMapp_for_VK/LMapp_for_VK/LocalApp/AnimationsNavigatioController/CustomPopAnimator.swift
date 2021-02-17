//
//  CustomPopAnimator.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 15.01.2021.
//

import UIKit

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
            
        destination.view.frame = source.view.frame
        
        let translation = CGAffineTransform(translationX: (source.view.frame.height - source.view.frame.width) / 2 + source.view.frame.width, y: -(source.view.frame.height - source.view.frame.width) / 2)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       delay: 0,
                       options: [],
                       animations: {
                        source.view.transform = translation.rotated(by: -(.pi * 90 / 180))
                       },
                       completion: {
                        finished in
                           if finished && !transitionContext.transitionWasCancelled {
                               source.view.transform = .identity
                           }
                           transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                       })
        
    }
}
