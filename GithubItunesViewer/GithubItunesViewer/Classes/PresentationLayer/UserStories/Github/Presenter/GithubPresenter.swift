//
//  GithubPresenter.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

enum ScreenState {
    case initial
    case loading
    case error(Error)
    case notFound
    case found([GithubRepository])
}

class GithubPresenter: MainModuleOutput, GithubViewOutput, GithubInteractorOutput, GithubModuleInput {
    
    weak var view: GithubViewInput?
    weak var output: GithubModuleOutput?
    var interactor: GithubInteractorInput?
    
    var state: ScreenState = .initial {
        didSet {
            change(state)
        }
    }
    var lastRequest: String = ""
    
    func didAskToDownloadImage(with configuration: ImageDownloaderConfiguration) {
        interactor?.downloadImage(with: configuration)
    }
    
    func didAskToTransition(with configuration: ImageTransitionConfiguration) {
        output?.didAskToTransition(with: configuration)
    }
    
    func provide(with output: GithubModuleOutput?) {
        self.output = output
    }
    
    func viewIsReady() {
        state = .initial
    }
    
    // MARK: Изменения состояния экрана
    
    func didTapRepeatButton() {
        loadData(for: lastRequest)
    }
    
    func didChange(_ text: String) {
        loadData(for: text)
    }
    
    func didReceive(_ repositories: [GithubRepository]) {
        if repositories.count > 0 {
            state = .found(repositories)
        } else {
            state = .notFound
        }
    }
    
    func didFail(with error: Error) {
        state = .error(error)
    }
    
    private func loadData(for request: String) {
        state = .loading
        lastRequest = request
        
        interactor?.requestRepositioryInformation(request)
    }
    
    private func change(_ state: ScreenState) {
        switch state {
            case .initial:
                view?.setupInitialState()
            case .loading:
                view?.showLoading()
            case .notFound:
                view?.showMessage("Данные не найдены")
            case .error(_):
                view?.showError("Возникла ошибка при загрузке")
            case .found(let repositories):
                view?.update(with: repositories)
        }
    }
}
