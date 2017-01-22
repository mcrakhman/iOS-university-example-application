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
    
    func networkClient() -> NetworkClient {
        return NetworkClientImplementation(session: URLSession.shared)
    }
    
    func requestBuilder() -> RequestBuilder {
        return RequestBuilderImplementation()
    }
    
    func urlBuilder() -> URLBuilder {
        return URLBuilderImplementation()
    }
    
    func jsonDeserializer() -> Deserializer {
        return JSONDeserializer()
    }
}
