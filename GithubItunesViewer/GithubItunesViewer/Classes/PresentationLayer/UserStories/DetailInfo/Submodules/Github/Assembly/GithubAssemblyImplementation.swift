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
       
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailInfoViewController.storyboardIdentifier) as! DetailInfoViewController
        viewController.embedIdentifier = EmbeddedModuleIdentifier.github.rawValue
        
        let presenter = DetailInfoPresenter()
        let githubService = assemblyFactory.serviceAssembly().githubService()
        let downloaderService = assemblyFactory.serviceAssembly().imageDownloaderService()
        let heightCalculator = assemblyFactory.helperAssembly().heightCalculator()
        let interactor = GithubInteractor()
        let viewModelFactory = GithubViewModelFactoryImplementation()
        let dataDisplayManager = DetailInfoDataDisplayManagerImplementation()
        let router = DetailInfoRouter()
        let animator = ScaleTransitionAnimator()
        
        interactor.githubService = githubService
        interactor.downloaderService = downloaderService
        interactor.output = presenter
        interactor.factory = viewModelFactory
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        viewController.output = presenter
        viewController.dataDisplayManager = dataDisplayManager
        
        router.animator = animator
        router.transitionHandler = viewController
        router.assemblyFactory = assemblyFactory
        
        dataDisplayManager.imageCellDelegate = viewController
        dataDisplayManager.heightCalculator = heightCalculator
        
        return viewController
    }
}
