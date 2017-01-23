//
//  GithubModuleOutput.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol GithubModuleOutput: class {
    func didAskToTransition(with configuration: ImageTransitionConfiguration)
}
