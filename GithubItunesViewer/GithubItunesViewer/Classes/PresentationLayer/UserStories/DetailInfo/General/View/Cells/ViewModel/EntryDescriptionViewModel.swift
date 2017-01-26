//
//  EntryDescriptionViewModel.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

struct EntryDescriptionViewModel: CellViewModel {
    var associatedCell: ConfigurableCell.Type
    let title: String
    let imageUrl: URL?
    let description: String
}
