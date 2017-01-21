//
//  MainViewController.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

enum SelectedScreen: Int {
    case github = 0
    case iTunes
}

class MainViewController: UIViewController, ViewControllerEmbedding {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var output: MainViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didChangeSegmentedControlValue(_ sender: Any) {
        guard let screen = SelectedScreen(rawValue: segmentedControl.selectedSegmentIndex) else {
            return
        }
        
        output?.didSelect(screen)
    }
    
}

