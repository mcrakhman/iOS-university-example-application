//
//  IconAssemblyImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class IconAssemblyImplementation: IconAssembly {
    func module(with image: UIImage) -> UIViewController {
        let storyboard = UIStoryboard(name: StoryboardConstants.main, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: IconViewController.storyboardIdentifier) as! IconViewController
        let presenter = IconPresenter()
        let router = IconRouter()
        
        presenter.iconImage = image
        presenter.router = router
        presenter.view = viewController
        
        viewController.output = presenter
        
        router.transitionHander = viewController
        
        return viewController
    }
}
