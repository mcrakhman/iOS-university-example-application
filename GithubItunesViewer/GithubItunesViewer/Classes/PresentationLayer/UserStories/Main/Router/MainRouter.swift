//
//  MainRouterImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

enum EmbeddedControllerIdentifiers {
    static let github = "Github"
    static let iTunes = "ITunes"
}

class MainRouter: MainRouterInput {
    
    var viewController: MainViewInput?
    var assemblyFactory: AssemblyFactory?
    var animator: ScaleTransitionAnimator?
    
    func showGithub() {
        guard let assemblyFactory = assemblyFactory else {
            return
        }
        showDetailModule(with: EmbeddedControllerIdentifiers.github,
                         constructor: assemblyFactory.githubAssembly().module)
    }
    
    func showITunes() {
        guard let assemblyFactory = assemblyFactory else {
            return
        }
        showDetailModule(with: EmbeddedControllerIdentifiers.iTunes,
                         constructor: assemblyFactory.iTunesAssembly().module)
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
    
    private func showDetailModule(with identifier: String, constructor: () -> UIViewController) {
        guard let viewController = viewController as? UIViewController,
              let rootViewController = viewController as? ViewControllerEmbedding else {
                return
        }
        
        var destinationViewController = rootViewController.findEmbeddableChild(with: identifier)
        
        if destinationViewController == nil {
            let newViewController = constructor()
            rootViewController.embed(newViewController)
            destinationViewController = newViewController
        }
        
        if let destinationViewController = destinationViewController {
            instantiateDataFlow(inputProvider: viewController as? MainModuleInputProvider,
                                outputProvider: destinationViewController as? MainModuleOutputProvider)
            rootViewController.embeddedTransition(to: destinationViewController)
        }
    }
    
    private func instantiateDataFlow(inputProvider: MainModuleInputProvider?, outputProvider: MainModuleOutputProvider?) {
        let input = inputProvider?.provideMainModuleInput() as? DetailInfoModuleOutput & MainModuleInput
        let output = outputProvider?.provideMainModuleOutput() as? MainModuleOutput & DetailInfoModuleInput
        input?.provide(with: output)
        output?.provide(with: input)
    }
}
