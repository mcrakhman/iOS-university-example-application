//
//  GithubInteractor.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class GithubInteractor: DetailInfoInteractorInput {
    
    var githubService: GithubService?
    var downloaderService: ImageDownloaderService?
    var output: DetailInfoInteractorOutput?
    var factory: GithubViewModelFactory?
    
    func send(_ requestString: String) {
        let configuration = GithubRepositorySearchConfiguration(searchString: requestString)
        githubService?.updateRepositories(with: configuration) { [weak self] response in
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
