//
//  DetailInfoViewInput.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol DetailInfoViewInput: class {
    func update(with entries: [CellViewModel])
    func showError(_ description: String)
    func showMessage(_ description: String)
    func showLoading()
    func setupInitialState()
}
