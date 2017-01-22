//
//  GithubDataDisplayManagerImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class GithubDataDisplayManagerImplementation: NSObject, GithubDataDisplayManager {
    
    var factory: GithubViewModelFactory?
    weak var imageCellDelegate: ImageCellDelegate?
    
    var viewModels: [CellViewModel] = []
    
    func update(with repositiories: [GithubRepository]) {
        guard let factory = factory else {
            return
        }
        
        viewModels = factory.viewModels(from: repositiories)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let cellIdentifier = viewModel.associatedCell.identifier
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ConfigurableCell,
           let delegate = imageCellDelegate {
            cell.configure(with: viewModel, delegate: delegate)
        }
        
        return UITableViewCell()
    }
}
