//
//  ITunesInteractor.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 26.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ITunesInteractor: DetailInfoInteractorInput {
    var iTunesService: ITunesService?
    var downloaderService: ImageDownloaderService?
    var output: DetailInfoInteractorOutput?
    var factory: ITunesViewModelFactory?
    
    func send(_ requestString: String) {
        let configuration = ITunesSearchConfiguration(searchString: requestString)
        iTunesService?.updateItems(with: configuration) { [weak self] response in
            guard let strongSelf = self, let factory = strongSelf.factory else {
                return
            }
            
            do {
                let repositories = try response()
                let entries = factory.viewModels(from: repositories)
                strongSelf.output?.didReceive(entries)
            } catch let error {
                strongSelf.output?.didFail(with: error)
            }
        }
    }
    
    func downloadImage(with configuration: ImageDownloaderConfiguration) {
        downloaderService?.downloadImage(with: configuration.url,
                                         completion: configuration.completion)
    }
}
