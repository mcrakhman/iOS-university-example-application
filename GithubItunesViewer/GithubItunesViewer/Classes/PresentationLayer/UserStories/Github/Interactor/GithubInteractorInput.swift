//
//  GithubInteractorInput.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol GithubInteractorInput: class {
    func requestRepositioryInformation(_ requestString: String)
}
