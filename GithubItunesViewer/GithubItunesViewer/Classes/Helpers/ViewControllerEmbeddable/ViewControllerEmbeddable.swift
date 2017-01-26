//
//  ViewControllerEmbeddable.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 24.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol ViewControllerEmbeddable {
    var embedIdentifier: String { get }
    
    func addEmbedIdentifier(_ identifier: String)
}
