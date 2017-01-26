//
//  ITunesViewModelFactory.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 26.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol ITunesViewModelFactory: class {
    func viewModels(from songData: [SongData]) -> [CellViewModel]
}
