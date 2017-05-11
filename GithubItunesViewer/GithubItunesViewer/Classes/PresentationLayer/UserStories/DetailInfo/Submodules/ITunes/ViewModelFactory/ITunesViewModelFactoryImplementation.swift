//
//  ITunesViewModelFactoryImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 26.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ITunesViewModelFactoryImplementation: ITunesViewModelFactory {
    func viewModels(from songData: [SongData]) -> [CellViewModel] {
        return songData.enumerated().map(songDataToViewModel)
    }
    
    private func songDataToViewModel(_ tuple: (offset: Int, element: SongData)) -> EntryDescriptionViewModel {
        let element = tuple.element
        let offset = tuple.offset
        
        let imageUrl = URL(string: element.imageUrlString)

        return EntryDescriptionViewModel(
            associatedCell: offset % 2 != 0 ? LeftDescriptionCell.self : RightDescriptionCell.self,
            title: element.authorName,
            imageUrl: imageUrl,
            description: element.trackName
        )
    }
}
