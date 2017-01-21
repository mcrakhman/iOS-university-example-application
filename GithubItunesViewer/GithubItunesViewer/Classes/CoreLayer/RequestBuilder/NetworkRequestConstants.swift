//
//  NetworkRequestConstants.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

enum NetworkRequestConstants {
    
    enum HeaderName: String {
        case contentType = "Content-Type"
        case accept = "Accept"
    }
    
    enum APIPath: String {
        case githubPath = "https://api.github.com/search/"
        case itunesPath = "b"
    }
    
    enum APIMethodName: String {
        case itunesMethod = "a"
        case githubMethod = "repositories"
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
}

