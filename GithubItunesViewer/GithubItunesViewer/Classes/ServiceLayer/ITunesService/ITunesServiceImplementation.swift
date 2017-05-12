//
//  ITunesServiceImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ITunesServiceImplementation: ITunesService {
    
    private let mapper: ITunesMapper
    private let networkClient: NetworkClient
    private let deserializer: Deserializer
    private let urlFactory: URLFactory
    private let requestFactory: RequestFactory
    
    private let queue = DispatchQueue.global()
    
    init(mapper: ITunesMapper,
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
    
    func updateItems(with configuration: ITunesSearchConfiguration,
                             completion: @escaping SongDataResponse) {
        do {
            let url = try urlFactory.create(withAPIPath: .iTunesPath,
                                           APIMethod: .iTunesMethod,
                                           configuration: configuration)
            let requestConfiguration = RequestFactoryConfiguration(method: .GET,
                                                                   timoutInterval: 20.0,
                                                                   url: url)
            let request = requestFactory.create(requestConfiguration)
            performNetworkOperations(with: request, completion: completion)
        } catch let error {
            completion { throw error }
        }
    }
    
    private func performNetworkOperations(with request: URLRequest,
                                          completion: @escaping SongDataResponse) {
        
        networkClient.perform(request: request) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.queue.async {
                do {
                    let response = try result()
                    let deserialized = try strongSelf.deserializer.deserialize(data: response)
                    let mapped = strongSelf.mapper.mapItemsArray(deserialized)
                    
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
