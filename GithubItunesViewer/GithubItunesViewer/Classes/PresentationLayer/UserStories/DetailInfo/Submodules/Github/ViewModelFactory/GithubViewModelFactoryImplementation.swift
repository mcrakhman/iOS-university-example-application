//
//  GithubViewModelFactoryImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class GithubViewModelFactoryImplementation: GithubViewModelFactory {
    
    func viewModels(from repositories: [GithubRepository]) -> [CellViewModel] {
        return repositories.enumerated().map(repositoryToViewModel)
    }
    
    private func repositoryToViewModel(_ tuple: (offset: Int, element: GithubRepository)) -> EntryDescriptionViewModel {
        let element = tuple.element
        let offset = tuple.offset
        
        let imageUrl = URL(string: element.avatarUrlString)

        return EntryDescriptionViewModel(
            associatedCell: offset % 2 != 0 ? LeftDescriptionCell.self : RightDescriptionCell.self,
            title: element.login,
            imageUrl: imageUrl,
            description: element.repositoryUrlString
        )
    }
}
