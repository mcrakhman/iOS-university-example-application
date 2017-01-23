//
//  IconAssembly.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

protocol IconAssembly: class {
    func module(with image: UIImage) -> UIViewController
}
