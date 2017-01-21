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
        let viewController = storyboard.instantiateViewController(withIdentifier: ITunesViewController.storyboardIdentifier) as! ITunesViewController
        
        return viewController
    }
}
