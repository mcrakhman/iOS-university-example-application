//
//  TableViewDataDisplayManager.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

protocol TableViewDataDisplayManager: UITableViewDataSource, UITableViewDelegate  {
    func dataSourceForTableView() -> UITableViewDataSource
    func delegateForTableView() -> UITableViewDelegate
}

extension TableViewDataDisplayManager {
    func dataSourceForTableView() -> UITableViewDataSource {
        return self
    }
    
    func delegateForTableView() -> UITableViewDelegate {
        return self
    }
}

