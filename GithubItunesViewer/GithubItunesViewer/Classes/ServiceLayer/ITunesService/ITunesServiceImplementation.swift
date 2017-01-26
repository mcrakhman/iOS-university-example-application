//
//  ITunesServiceImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ITunesServiceImplementation: ITunesService {
    
    let mapper: ITunesMapper
    let networkClient: NetworkClient
    let deserializer: Deserializer
    let urlBuilder: URLBuilder
    let requestBuilder: RequestBuilder
    
    let queue = DispatchQueue.global()
    
    init(mapper: ITunesMapper,
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
    
    func updateItems(with configuration: ITunesSearchConfiguration,
                             completion:@escaping SongDataResponse) {
        do {
            let url = try urlBuilder.build(withAPIPath: .iTunesPath,
                                           APIMethod: .iTunesMethod,
                                           configuration: configuration)
            let requestConfiguration = RequestBuilderConfiguration(method: .GET, timoutInterval: 20.0, url: url)
            let request = requestBuilder.build(requestConfiguration)
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
                    let mapped = try strongSelf.mapper.mapItemsArray(deserialized)
                    
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
