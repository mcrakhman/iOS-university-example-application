//
//  GithubService.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

typealias RepositoryResponse = (() throws -> [GithubRepository]) -> ()

protocol GithubService: class {
    func updateRepositories(with configuration: GithubRepositorySearchConfiguration, completion: @escaping RepositoryResponse)
}
