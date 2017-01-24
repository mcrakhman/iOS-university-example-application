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
        let githubService = assemblyFactory.serviceAssembly().iTunesService()
        let downloaderService = assemblyFactory.serviceAssembly().imageDownloaderService()
        let heightCalculator = assemblyFactory.helperAssembly().heightCalculator()
        let interactor = GithubInteractor()
        let viewModelFactory = GithubViewModelFactoryImplementation()
        let dataDisplayManager = GithubDataDisplayManagerImplementation()
        
        interactor.githubService = githubService
        interactor.downloaderService = downloaderService
        interactor.output = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        
        viewController.output = presenter
        viewController.dataDisplayManager = dataDisplayManager
        
        dataDisplayManager.factory = viewModelFactory
        dataDisplayManager.imageCellDelegate = viewController
        dataDisplayManager.heightCalculator = heightCalculator
        
        return viewController
    }
}
