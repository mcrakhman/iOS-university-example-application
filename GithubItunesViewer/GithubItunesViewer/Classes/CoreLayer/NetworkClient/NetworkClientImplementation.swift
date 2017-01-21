//
//  NetworkClientImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

enum NetworkClientError: Error {
    case emptyDataReturned
}

class NetworkClientImplementation: NetworkClient {
    private let session: URLSession
    
    // MARK: Конструкторы
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Методы протокола NetworkClient
    
    func perform(request: URLRequest, completion: NetworkClientCompletion?) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            completion? {
                if let networkError = error {
                    throw networkError
                }
                
                guard let responseData = data else {
                    throw NetworkClientError.emptyDataReturned
                }
                
                return responseData
            }
        }
        dataTask.resume()
    }
}
