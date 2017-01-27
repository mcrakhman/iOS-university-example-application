//
//  ITunesAssemblyImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class ITunesAssemblyImplementation: ITunesAssembly {
    
    let assemblyFactory: AssemblyFactory
    
    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }
    
    func module() -> UIViewController {
        let storyboard = UIStoryboard(name: StoryboardConstants.main, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailInfoViewController.storyboardIdentifier) as! DetailInfoViewController
        viewController.embedIdentifier = EmbeddedControllerIdentifiers.iTunes
        
        let presenter = DetailInfoPresenter()
        let iTunesService = assemblyFactory.serviceAssembly().iTunesService()
        let downloaderService = assemblyFactory.serviceAssembly().imageDownloaderService()
        let heightCalculator = assemblyFactory.helperAssembly().heightCalculator()
        let interactor = ITunesInteractor()
        let viewModelFactory = ITunesViewModelFactoryImplementation()
        let dataDisplayManager = DetailInfoDataDisplayManagerImplementation()
        let router = DetailInfoRouter()
        let animator = ScaleTransitionAnimator()
        
        interactor.iTunesService = iTunesService
        interactor.downloaderService = downloaderService
        interactor.output = presenter
        interactor.factory = viewModelFactory
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        router.animator = animator
        router.transitionHandler = viewController
        router.assemblyFactory = assemblyFactory
        
        viewController.output = presenter
        viewController.dataDisplayManager = dataDisplayManager
        
        dataDisplayManager.imageCellDelegate = viewController
        dataDisplayManager.heightCalculator = heightCalculator
        
        return viewController
    }
}
