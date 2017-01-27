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

enum MainViewControllerConstants {
    static let throttleDelay: TimeInterval = 1.0
}

class MainViewController: UIViewController, ViewControllerEmbedding, MainViewInput, UISearchBarDelegate {
    
    var container: UIView {
        return containerView
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var output: MainViewOutput?
    var throttler: Throttler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        changeScreen()
    }
    
    @IBAction func didChangeSegmentedControlValue(_ sender: Any) {
        changeScreen()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttler?.throttle(MainViewControllerConstants.throttleDelay) {
            self.output?.didChange(searchText)
            self.searchBar.resignFirstResponder()
        }
    }
    
    private func changeScreen() {
        guard let screen = SelectedScreen(rawValue: segmentedControl.selectedSegmentIndex) else {
            return
        }
        
        output?.didSelect(screen)
    }
}

