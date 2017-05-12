//
//  CoreAssemblyImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class CoreAssemblyImplementation: CoreAssembly {
    func githubMapper() -> GithubMapper {
        return GithubMapperImplementation()
    }
    
    func iTunesMapper() -> ITunesMapper {
        return ITunesMapperImplementation()
    }
    
    func networkClient() -> NetworkClient {
        return NetworkClientImplementation(session: URLSession.shared)
    }
    
    func requestFactory() -> RequestFactory {
        return RequestFactoryImplementation()
    }
    
    func urlFactory() -> URLFactory {
        return URLFactoryImplementation()
    }
    
    func jsonDeserializer() -> Deserializer {
        return JSONDeserializer()
    }
}
