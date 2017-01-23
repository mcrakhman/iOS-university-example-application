//
//  MainAssemblyImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class MainAssemblyImplementation: MainAssembly {
    
    let assemblyFactory: AssemblyFactory
    
    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }
    
    func module() -> UIViewController {
        let helperAssembly = assemblyFactory.helperAssembly()
        
        let storyboard = UIStoryboard(name: StoryboardConstants.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: MainViewController.storyboardIdentifier) as! MainViewController
        
        let presenter = MainPresenter()
        let router = MainRouter()
        let throttler = helperAssembly.throttler()
        
        presenter.router = router
        presenter.view = viewController
        router.viewController = viewController
        router.assemblyFactory = assemblyFactory
        viewController.output = presenter
        viewController.throttler = throttler
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
