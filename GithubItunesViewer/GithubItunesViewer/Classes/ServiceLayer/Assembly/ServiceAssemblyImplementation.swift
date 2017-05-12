//
//  ServiceAssemblyImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ServiceAssemblyImplementation: ServiceAssembly {
    let assemblyFactory: AssemblyFactory
    
    init(assemblyFactory: AssemblyFactory) {
        self.assemblyFactory = assemblyFactory
    }
    
    func githubService() -> GithubService {
        let coreAssembly = assemblyFactory.coreAssembly()
        let mapper = coreAssembly.githubMapper()
        let networkClient = coreAssembly.networkClient()
        let deserializer = coreAssembly.jsonDeserializer()
        let urlFactory = coreAssembly.urlFactory()
        let requestFactory = coreAssembly.requestFactory()
        
        return GithubServiceImplementation(mapper: mapper,
                                           networkClient: networkClient,
                                           deserializer: deserializer,
                                           urlFactory: urlFactory,
                                           requestFactory: requestFactory)
    }
    
    func iTunesService() -> ITunesService {
        let coreAssembly = assemblyFactory.coreAssembly()
        let mapper = coreAssembly.iTunesMapper()
        let networkClient = coreAssembly.networkClient()
        let deserializer = coreAssembly.jsonDeserializer()
        let urlFactory = coreAssembly.urlFactory()
        let requestFactory = coreAssembly.requestFactory()
        
        return ITunesServiceImplementation(mapper: mapper,
                                           networkClient: networkClient,
                                           deserializer: deserializer,
                                           urlFactory: urlFactory,
                                           requestFactory: requestFactory)
    }
    
    func imageDownloaderService() -> ImageDownloaderService {
        let coreAssembly = assemblyFactory.coreAssembly()
        let networkClient = coreAssembly.networkClient()
        
        return ImageDownloaderServiceImplementation(networkClient: networkClient)
    }
}
