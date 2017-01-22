//
//  GithubViewController.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class GithubViewController: UIViewController, GithubViewInput, MainModuleOutputProvider {
    var output: GithubViewOutput?
    
    func provideMainModuleOutput() -> MainModuleOutput? {
        return output as? MainModuleOutput
    }
}

