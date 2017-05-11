//
//  MainRouterImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

enum EmbeddedModuleIdentifier: String {
    case github = "Github"
    case iTunes = "ITunes"
}

class MainRouter: MainRouterInput {
    
    weak var transitionHandler: MainViewInput?
    weak var assemblyFactory: AssemblyFactory?
    var currentModule: EmbeddedModuleIdentifier = .github
    
    func showGithub(with input: MainModuleInput) {
        guard let assemblyFactory = assemblyFactory else {
            return
        }

        showDetailModule(with: EmbeddedModuleIdentifier.github.rawValue,
                         input: input,
                         constructor: assemblyFactory.githubAssembly().module)
        currentModule = .github
    }
    
    func showITunes(with input: MainModuleInput) {
        guard let assemblyFactory = assemblyFactory else {
            return
        }

        showDetailModule(with: EmbeddedModuleIdentifier.iTunes.rawValue,
                         input: input,
                         constructor: assemblyFactory.iTunesAssembly().module)
        currentModule = .iTunes
    }

    private func showDetailModule(with identifier: String,
                                  input: MainModuleInput,
                                  constructor: () -> UIViewController) {
        guard let viewController = transitionHandler as? UIViewController,
              let rootViewController = viewController as? ViewControllerEmbedding else {
                return
        }
        
        var destinationVC = rootViewController.findEmbeddableChild(with: identifier)
        let sourceVC = rootViewController.findEmbeddableChild(with: currentModule.rawValue)

        switch (destinationVC, sourceVC) {
        case (nil, nil):
            let newViewController = constructor()
            rootViewController.embed(newViewController)
            destinationVC = newViewController

        case (nil, .some(let sourceVC)):
            let newViewController = constructor()
            rootViewController.embedAndTransition(from: sourceVC,
                                                  to: newViewController)
            destinationVC = newViewController

        case (.some(let destinationVC), .some(let sourceVC)):
            rootViewController.transition(from: sourceVC,
                                          to: destinationVC)

        default: break
        }

        instantiateDataFlow(input: input,
                            outputProvider: destinationVC as? MainModuleOutputProvider)
    }
    
    private func instantiateDataFlow(input: MainModuleInput,
                                     outputProvider: MainModuleOutputProvider?) {
        let output = outputProvider?.provideMainModuleOutput()
        input.provide(with: output)
    }
}
