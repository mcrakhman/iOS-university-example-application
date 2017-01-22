//
//  LeftDescriptionCell.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class LeftDescriptionCell: UITableViewCell, ConfigurableCell {
    func configure(with viewModel: CellViewModel, delegate: CellDelegate) {
        guard let viewModel = viewModel as? GithubRepositoryViewModel else {
            return
        }
    }
}
