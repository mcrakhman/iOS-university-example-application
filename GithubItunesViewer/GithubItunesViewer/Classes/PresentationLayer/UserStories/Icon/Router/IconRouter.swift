//
//  Router.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class IconRouter: IconRouterInput {
    var transitionHander: IconViewInput?
    
    func closeModule() {
        guard let viewController = transitionHander as? UIViewController else {
            return
        }
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
