//
//  GithubMapperImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

enum MapperError: Error {
    case invalidData
}

class GithubMapperImplementation: GithubMapper {
    func mapRepositoryArray(_ data: Any) -> [GithubRepository] {
        guard let dictionary = data as? [String: Any] else {
            return []
        }
        
        let items = dictionary[stringDictArray: "items"] ?? []
        let repositories = items.flatMap(mapRepository)
        return repositories
    }
    
    private func mapRepository(_ dictionary: [String: Any]) -> GithubRepository? {
        guard let owner = dictionary[stringDict: "owner"],
              let urlString = owner["url"] as? String,
              let avatarUrlString = owner["avatar_url"] as? String,
              let login = owner["login"] as? String 
            else {
                return nil
        }
        
        return GithubRepository(avatarUrlString: avatarUrlString,
                                login: login,
                                repositoryUrlString: urlString)

    }
}
