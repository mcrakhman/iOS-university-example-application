//
//  GithubPresenter.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class GithubPresenter: MainModuleOutput, GithubViewOutput, GithubInteractorOutput {
    
    weak var view: GithubViewInput?
    var interactor: GithubInteractorInput?
    
    func didChange(_ text: String) {
        interactor?.requestRepositioryInformation(text)
    }
    
    func didAskToDownloadImage(with configuration: ImageDownloaderConfiguration) {
        interactor?.downloadImage(with: configuration)
    }
    
    func didReceive(_ repositories: [GithubRepository]) {
        view?.update(with: repositories)
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}
