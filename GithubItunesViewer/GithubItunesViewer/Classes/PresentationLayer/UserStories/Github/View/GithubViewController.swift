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
    var dataDisplayManager: GithubDataDisplayManager?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        let rightCellNib = UINib(nibName: RightDescriptionCell.identifier, bundle: Bundle.main)
        tableView.register(rightCellNib, forCellReuseIdentifier: RightDescriptionCell.identifier)
        
        let leftCellNib = UINib(nibName: LeftDescriptionCell.identifier, bundle: Bundle.main)
        tableView.register(leftCellNib, forCellReuseIdentifier: LeftDescriptionCell.identifier)
        
        tableView.delegate = dataDisplayManager?.delegateForTableView()
        tableView.dataSource = dataDisplayManager?.dataSourceForTableView()
    }
    
    func update(with repositories: [GithubRepository]) {
        dataDisplayManager?.update(with: repositories)
        tableView.reloadData()
    }
    
    func provideMainModuleOutput() -> MainModuleOutput? {
        return output as? MainModuleOutput
    }
}

