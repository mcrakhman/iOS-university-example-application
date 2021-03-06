//
//  RequestFactoryImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class RequestFactoryImplementation: RequestFactory {
    
    func create(_ configuration: RequestFactoryConfiguration) -> URLRequest {
        var request = URLRequest(url: configuration.url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: configuration.timoutInterval)
        
        request.httpMethod = configuration.method.rawValue
        addHeaders(to: &request)
        
        return request
    }
    
    func addHeaders(to request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: NetworkRequestConstants.HeaderName.contentType.rawValue)
        request.setValue("application/json", forHTTPHeaderField: NetworkRequestConstants.HeaderName.accept.rawValue)
    }
}
