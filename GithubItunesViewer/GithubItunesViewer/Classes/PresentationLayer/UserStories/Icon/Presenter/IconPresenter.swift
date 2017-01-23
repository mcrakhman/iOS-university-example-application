//
//  IconPresenter.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class IconPresenter: IconViewOutput {
    var router: IconRouterInput?
    weak var view: IconViewInput?
    
    var iconImage: UIImage?
    
    func viewIsReady() {
        guard let image = iconImage else {
            return
        }
        
        view?.setupInitialState(with: image)
    }
    
    func didTapImage() {
        router?.closeModule()
    }
}
