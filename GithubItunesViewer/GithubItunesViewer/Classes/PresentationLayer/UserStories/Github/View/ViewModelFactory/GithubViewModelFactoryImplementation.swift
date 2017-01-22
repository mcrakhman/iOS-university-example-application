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
    
    private func repositoryToViewModel(_ tuple: (offset: Int, element: GithubRepository)) -> GithubRepositoryViewModel {
        let element = tuple.element
        let offset = tuple.offset
        
        let imageUrl = URL(string: element.avatarUrlString)
        let userUrl = URL(string: element.avatarUrlString)
        
        if offset % 2 == 0 {
            return GithubRepositoryViewModel(associatedCell: LeftDescriptionCell.self,
                                             login: element.login,
                                             imageUrl: imageUrl,
                                             userUrl: userUrl)
        } else {
            return GithubRepositoryViewModel(associatedCell: RightDescriptionCell.self,
                                             login: element.login,
                                             imageUrl: imageUrl,
                                             userUrl: userUrl)
        }
    }
}
