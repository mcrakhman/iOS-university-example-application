//
//  DetailInfoPresenter.swift
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
    case found([CellViewModel])
}

class DetailInfoPresenter: MainModuleOutput, DetailInfoViewOutput, DetailInfoInteractorOutput {
    
    weak var view: DetailInfoViewInput?
    var interactor: DetailInfoInteractorInput?
    var router: DetailInfoRouterInput?
    
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
        router?.openImage(with: configuration)
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
    
    func didReceive(_ entries: [CellViewModel]) {
        if entries.count > 0 {
            state = .found(entries)
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
        
        interactor?.send(request)
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
            case .found(let entries):
                view?.update(with: entries)
        }
    }
}
