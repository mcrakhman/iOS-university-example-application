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
    
    var viewController: UIViewController?
    var assemblyFactory: AssemblyFactory?
    
    func showGithub() {
        guard let viewController = viewController,
              let assemblyFactory = assemblyFactory,
              let rootViewController = viewController as? ViewControllerEmbedding else {
            return
        }
        
        var existingViewController = viewController.child(ofType: GithubViewInput.self)
                
        if existingViewController == nil {
            let newViewController = assemblyFactory.githubAssembly().module()
            rootViewController.embed(newViewController)
            existingViewController = newViewController
        }
        
        if let existingViewController = existingViewController {
            rootViewController.embeddedTransition(to: existingViewController)
        }
    }
    
    func showITunes() {
        guard let viewController = viewController,
            let assemblyFactory = assemblyFactory,
            let rootViewController = viewController as? ViewControllerEmbedding else {
                return
        }
        
        var existingViewController = viewController.child(ofType: ITunesViewInput.self)
        
        if existingViewController == nil {
            let newViewController = assemblyFactory.iTunesAssembly().module()
            rootViewController.embed(newViewController)
            existingViewController = newViewController
        }
        
        if let existingViewController = existingViewController {
            rootViewController.embeddedTransition(to: existingViewController)
        }
    }
}
