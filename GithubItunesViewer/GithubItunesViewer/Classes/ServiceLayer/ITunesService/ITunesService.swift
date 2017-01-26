//
//  ITunesService.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

typealias SongDataResponse = (() throws -> [SongData]) -> ()

protocol ITunesService: class {
    func updateItems(with configuration: ITunesSearchConfiguration, completion: @escaping SongDataResponse)
}
