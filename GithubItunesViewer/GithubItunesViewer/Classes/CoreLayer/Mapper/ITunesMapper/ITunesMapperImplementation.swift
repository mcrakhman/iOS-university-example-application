//
//  ITunesMapperImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ITunesMapperImplementation: ITunesMapper {
    func mapItemsArray(_ data: Any) -> [SongData] {
        guard let dictionary = data as? [String: Any] else {
            return []
        }
        
        let results = dictionary[stringDictArray: "results"] ?? []
        let items = results.flatMap(mapItem)
        return items
    }
    
    private func mapItem(_ dictionary: [String: Any]) -> SongData? {
        guard let trackName = dictionary["trackName"] as? String,
              let imageUrlString = dictionary["artworkUrl100"] as? String,
              let authorName = dictionary["artistName"] as? String
            else {
                return nil
        }
        
        return SongData(authorName: authorName,
                        imageUrlString: imageUrlString,
                        trackName: trackName)
    }
}
