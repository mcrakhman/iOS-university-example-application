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
    
    weak var transitionHandler: MainViewInput?
    weak var assemblyFactory: AssemblyFactory?
    
    func showGithub(with input: MainModuleInput) {
        guard let assemblyFactory = assemblyFactory else {
            return
        }
        showDetailModule(with: EmbeddedControllerIdentifiers.github,
                         input: input,
                         constructor: assemblyFactory.githubAssembly().module)
    }
    
    func showITunes(with input: MainModuleInput) {
        guard let assemblyFactory = assemblyFactory else {
            return
        }
        showDetailModule(with: EmbeddedControllerIdentifiers.iTunes,
                         input: input,
                         constructor: assemblyFactory.iTunesAssembly().module)
    }

    private func showDetailModule(with identifier: String,
                                  input: MainModuleInput,
                                  constructor: () -> UIViewController) {
        guard let viewController = transitionHandler as? UIViewController,
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
            instantiateDataFlow(input: input,
                                outputProvider: destinationViewController as? MainModuleOutputProvider)
            rootViewController.embeddedTransition(to: destinationViewController)
        }
    }
    
    private func instantiateDataFlow(input: MainModuleInput,
                                     outputProvider: MainModuleOutputProvider?) {
        let output = outputProvider?.provideMainModuleOutput()
        input.provide(with: output)
    }
}
