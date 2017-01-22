//
//  GithubRepositoryViewModel.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct GithubRepositoryViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type
    let login: String
    let imageUrl: URL?
    let userUrl: URL?
}
