//
//  GithubRepositorySearchConfiguration.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct GithubRepositorySearchConfiguration: URLParametersTransformable, URLBuilderConfiguration {
    let searchString: String
    
    func toDictionary() -> [String : String] {
        var parameter = searchString.components(separatedBy: " ").filter { $0 != "" }.reduce("") { $0.0 + "+" + $0.1 }
        if !parameter.isEmpty {
             parameter.remove(at: parameter.startIndex)
        }
        
        return ["q": parameter]
    }
}
