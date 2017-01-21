//
//  MainAssembly.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

enum StoryboardConstants {
    static let main = "Main"
}

protocol MainAssembly: class {
    func module() -> UIViewController
}
