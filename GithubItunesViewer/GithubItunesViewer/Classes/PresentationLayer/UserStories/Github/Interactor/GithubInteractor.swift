//
//  GithubInteractor.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class GithubInteractor: GithubInteractorInput {
    
    var githubService: GithubService?
    var downloaderService: ImageDownloaderService?
    var output: GithubInteractorOutput?
    
    func requestRepositioryInformation(_ requestString: String) {
        let configuration = GithubRepositorySearchConfiguration(searchString: requestString)
        githubService?.updateRepositiories(with: configuration) { [weak self] response in
            guard let strongSelf = self else {
                return
            }
            
            do {
                let repositories = try response()
                strongSelf.output?.didReceive(repositories)
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
