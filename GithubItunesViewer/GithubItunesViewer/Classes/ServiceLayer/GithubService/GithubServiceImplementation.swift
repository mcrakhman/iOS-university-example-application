//
//  GithubServiceImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class GithubServiceImplementation: GithubService {
    
    private let mapper: GithubMapper
    private let networkClient: NetworkClient
    private let deserializer: Deserializer
    private let urlFactory: URLFactory
    private let requestFactory: RequestFactory
    
    private let queue = DispatchQueue.global()
    
    init(mapper: GithubMapper,
         networkClient: NetworkClient,
         deserializer: Deserializer,
         urlFactory: URLFactory,
         requestFactory: RequestFactory) {
        self.mapper = mapper
        self.networkClient = networkClient
        self.deserializer = deserializer
        self.urlFactory = urlFactory
        self.requestFactory = requestFactory
    }
    
    func updateRepositories(with configuration: GithubRepositorySearchConfiguration,
                            completion: @escaping RepositoryResponse) {
        do {
            let url = try urlFactory.create(withAPIPath: .githubPath,
                                            APIMethod: .githubMethod,
                                            configuration: configuration)
            let requestFactoryConfiguration = RequestFactoryConfiguration(method: .GET,
                                                                          timoutInterval: 60.0,
                                                                          url: url)
            let request = requestFactory.create(requestFactoryConfiguration)
            performNetworkOperations(with: request, completion: completion)
        } catch let error {
            completion { throw error }
        }
    }
    
    private func performNetworkOperations(with request: URLRequest,
                                          completion: @escaping RepositoryResponse) {
        
        networkClient.perform(request: request) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.queue.async {
                do {
                    let response = try result()
                    let deserialized = try strongSelf.deserializer.deserialize(data: response)
                    let mapped = strongSelf.mapper.mapRepositoryArray(deserialized)
                    
                    DispatchQueue.main.async {
                        completion { return mapped }
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion { throw error }
                    }
                }
            }
        }
    }
}
