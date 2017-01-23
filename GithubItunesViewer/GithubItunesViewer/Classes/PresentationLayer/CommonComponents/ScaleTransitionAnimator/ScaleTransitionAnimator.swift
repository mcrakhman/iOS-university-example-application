//
//  ScaleTransitionAnimator.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class ScaleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.4
    var presentingTransition = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
                return
        }
        if presentingTransition {
            presentingTransition(toView: toView,
                                 fromView: fromView,
                                 transitionContext: transitionContext)
        } else {
            dissmissingTransition(toView: toView,
                                  fromView: fromView,
                                  transitionContext: transitionContext)
        }
    }
    
    func dissmissingTransition(toView: UIView,
                               fromView: UIView,
                               transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let scaledView = fromView
        let previousColor = scaledView.backgroundColor
        
        scaledView.backgroundColor = UIColor.clear
        let scale = originFrame.height / scaledView.frame.height
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: scaledView)
        
        UIView.animate(withDuration: duration,
                       animations: {
                            scaledView.transform = scaleTransform
                            scaledView.center = CGPoint(x: self.originFrame.midX, y: self.originFrame.midY)
                        }) { _ in
                            scaledView.backgroundColor = previousColor
                            transitionContext.completeTransition(true)
                        }
    }
    
    func presentingTransition(toView: UIView,
                              fromView: UIView,
                              transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let scaledView = toView
        let previousColor = scaledView.backgroundColor
        
        scaledView.backgroundColor = UIColor.clear
        let scale = originFrame.height / scaledView.frame.height
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        let destinationFrame = scaledView.frame
        
        scaledView.transform = scaleTransform
        scaledView.center = CGPoint(x: self.originFrame.midX, y: self.originFrame.midY)
        scaledView.clipsToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: scaledView)
        
        UIView.animate(withDuration: duration,
                       animations: {
                            scaledView.transform = CGAffineTransform.identity
                            scaledView.center = CGPoint(x: destinationFrame.midX, y: destinationFrame.midY)
                        }) { _ in
                            scaledView.backgroundColor = previousColor
                            transitionContext.completeTransition(true)
                        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentingTransition = true
        
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentingTransition = false
        
        return self
    }
}
