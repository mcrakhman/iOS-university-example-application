//
//  MainPresenter.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class MainPresenter: MainViewOutput, MainModuleInput {
    
    var router: MainRouterInput?
    weak var moduleOutput: MainModuleOutput?
    weak var view: MainViewInput?
    
    func didSelect(_ screen: SelectedScreen) {
        switch screen {
            case .github: router?.showGithub(with: self)
            case .iTunes: router?.showITunes(with: self)
        }
    }
    
    func didChange(_ text: String) {
        moduleOutput?.didChange(text)
    }
    
    func provide(with output: MainModuleOutput?) {
        moduleOutput = output
    }
}
