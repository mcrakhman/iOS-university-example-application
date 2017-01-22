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
    
    func didSelect(_ screen: SelectedScreen) {
        switch screen {
            case .github: router?.showGithub()
            case .iTunes: router?.showITunes()
        }
    }
    
    func didChange(_ text: String) {
        moduleOutput?.didChange(text)
    }
    
    func provide(with output: MainModuleOutput?) {
        moduleOutput = output
    }
}
