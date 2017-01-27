//
//  UIViewController.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

extension UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
