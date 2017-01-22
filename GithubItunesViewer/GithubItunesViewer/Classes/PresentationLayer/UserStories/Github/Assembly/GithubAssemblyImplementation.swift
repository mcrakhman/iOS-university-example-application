//
//  GithubAssemblyImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class GithubAssemblyImplementation: GithubAssembly {
    
    let assemblyFactory: AssemblyFactory
    
    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }
    
    func module() -> UIViewController {
        let storyboard = UIStoryboard(name: StoryboardConstants.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: GithubViewController.storyboardIdentifier) as! GithubViewController
        
        let presenter = GithubPresenter()
        let githubService = assemblyFactory.serviceAssembly().githubService()
        let interactor = GithubInteractor()
        
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.output = presenter
        interactor.githubService = githubService
        interactor.output = presenter
        
        let viewModelFactory = GithubViewModelFactoryImplementation()
        let dataDisplayManager = GithubDataDisplayManagerImplementation()
        dataDisplayManager.factory = viewModelFactory
        viewController.dataDisplayManager = dataDisplayManager
        
        return viewController
    }
}
