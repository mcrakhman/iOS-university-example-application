//
//  DetailInfoRouter.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 27.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class DetailInfoRouter: DetailInfoRouterInput {
    var animator: ScaleTransitionAnimator?
    weak var transitionHandler: DetailInfoViewInput?
    weak var assemblyFactory: AssemblyFactory?
    
    func openImage(with configuration: ImageTransitionConfiguration) {
        guard let viewController = transitionHandler as? UIViewController,
            let assemblyFactory = assemblyFactory else {
                return
        }
        
        let iconViewController = assemblyFactory.iconAssembly().module(with: configuration.image)
        let animator = assemblyFactory.helperAssembly().scaleAnimator()
        
        iconViewController.transitioningDelegate = animator
        animator.originFrame = configuration.frame
        
        viewController.present(iconViewController, animated: true, completion: nil)
        
        self.animator = animator
    }
}
