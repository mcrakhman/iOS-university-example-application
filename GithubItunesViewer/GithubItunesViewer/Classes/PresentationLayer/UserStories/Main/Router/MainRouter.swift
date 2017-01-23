//
//  MainRouterImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: MainRouterInput {
    
    var viewController: MainViewInput?
    var assemblyFactory: AssemblyFactory?
    var animator: ScaleTransitionAnimator?
    
    func showGithub() {
        guard let viewController = viewController as? UIViewController,
              let assemblyFactory = assemblyFactory,
              let rootViewController = viewController as? ViewControllerEmbedding else {
            return
        }
        
        var destinationViewController = viewController.child(ofType: GithubViewInput.self)
                
        if destinationViewController == nil {
            let newViewController = assemblyFactory.githubAssembly().module()
            rootViewController.embed(newViewController)
            destinationViewController = newViewController
        }
        
        if let destinationViewController = destinationViewController {
            instantiateDataFlow(inputProvider: viewController as? MainModuleInputProvider,
                                outputProvider: destinationViewController as? MainModuleOutputProvider)
            rootViewController.embeddedTransition(to: destinationViewController)
        }
    }
    
    func showITunes() {
        guard let viewController = viewController as? UIViewController,
              let assemblyFactory = assemblyFactory,
              let rootViewController = viewController as? ViewControllerEmbedding else {
                return
        }
        
        var destinationViewController = viewController.child(ofType: ITunesViewInput.self)
        
        if destinationViewController == nil {
            let newViewController = assemblyFactory.iTunesAssembly().module()
            rootViewController.embed(newViewController)
            destinationViewController = newViewController
        }
        
        if let destinationViewController = destinationViewController {
            instantiateDataFlow(inputProvider: viewController as? MainModuleInputProvider,
                                outputProvider: destinationViewController as? MainModuleOutputProvider)
            rootViewController.embeddedTransition(to: destinationViewController)
        }
    }
    
    func show(_ configuration: ImageTransitionConfiguration) {
        guard let viewController = viewController as? UIViewController,
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
    
    private func instantiateDataFlow(inputProvider: MainModuleInputProvider?, outputProvider: MainModuleOutputProvider?) {
        let input = inputProvider?.provideMainModuleInput() as? GithubModuleOutput & MainModuleInput
        let output = outputProvider?.provideMainModuleOutput() as? MainModuleOutput & GithubModuleInput
        input?.provide(with: output)
        output?.provide(with: input)
    }
}
