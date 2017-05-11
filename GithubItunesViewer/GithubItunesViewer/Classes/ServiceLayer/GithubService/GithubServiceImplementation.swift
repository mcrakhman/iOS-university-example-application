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
    private let urlBuilder: URLBuilder
    private let requestBuilder: RequestBuilder
    
    private let queue = DispatchQueue.global()
    
    init(mapper: GithubMapper,
         networkClient: NetworkClient,
         deserializer: Deserializer,
         urlBuilder: URLBuilder,
         requestBuilder: RequestBuilder) {
        self.mapper = mapper
        self.networkClient = networkClient
        self.deserializer = deserializer
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
    }
    
    func updateRepositories(with configuration: GithubRepositorySearchConfiguration,
                            completion: @escaping RepositoryResponse) {
        do {
            let url = try urlBuilder.build(withAPIPath: .githubPath,
                                           APIMethod: .githubMethod,
                                           configuration: configuration)
            let requestBuilderConfiguration = RequestBuilderConfiguration(method: .GET,
                                                                          timoutInterval: 60.0,
                                                                          url: url)
            let request = requestBuilder.build(requestBuilderConfiguration)
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
