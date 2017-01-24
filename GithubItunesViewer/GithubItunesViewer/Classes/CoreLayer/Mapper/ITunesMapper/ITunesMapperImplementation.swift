//
//  ITunesMapperImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ITunesMapperImplementation: ITunesMapper {
    func mapItemsArray(_ data: Any) throws -> [GithubRepository] {
        guard let dictionary = data as? [String: Any] else {
            throw MapperError.invalidData
        }
        
        let items = dictionary[stringDictArray: "results"] ?? []
        let repositories = items.map(mapItem)
        return repositories
    }
    
    private func mapItem(_ dictionary: [String: Any]) -> GithubRepository {
        let urlString       = dictionary["trackName"] as? String ?? ""
        let avatarUrlString = dictionary["artworkUrl100"] as? String ?? ""
        let login           = dictionary["artistName"] as? String ?? ""
        
        return GithubRepository(avatarUrlString: avatarUrlString,
                                login: login,
                                repositoryUrlString: urlString)
        
    }
}
