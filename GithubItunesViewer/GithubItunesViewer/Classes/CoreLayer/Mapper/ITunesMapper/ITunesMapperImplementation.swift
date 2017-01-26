//
//  ITunesMapperImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ITunesMapperImplementation: ITunesMapper {
    func mapItemsArray(_ data: Any) throws -> [SongData] {
        guard let dictionary = data as? [String: Any] else {
            throw MapperError.invalidData
        }
        
        let results = dictionary[stringDictArray: "results"] ?? []
        let items = results.map(mapItem)
        return items
    }
    
    private func mapItem(_ dictionary: [String: Any]) -> SongData {
        let trackName      = dictionary["trackName"] as? String ?? ""
        let imageUrlString = dictionary["artworkUrl100"] as? String ?? ""
        let authorName     = dictionary["artistName"] as? String ?? ""
        
        return SongData(authorName: authorName, imageUrlString: imageUrlString, trackName: trackName)
        
    }
}
