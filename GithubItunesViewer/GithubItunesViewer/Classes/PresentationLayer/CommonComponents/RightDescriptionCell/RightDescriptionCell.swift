//
//  RightDescriptionCell.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class RightDescriptionCell: UITableViewCell, ConfigurableCell {
    func configure(with viewModel: CellViewModel, delegate: CellDelegate) {
        guard let viewModel = viewModel as? GithubRepositoryViewModel,
              let delegate = delegate as? ImageCellDelegate else {
            return
        }
        
        if let url = viewModel.imageUrl {
            let completion: (UIImage) -> () = { [weak self] image in
                print("Completed")
            }
            let configuration = ImageDownloaderConfiguration(url: url, completion: completion)
            delegate.downloadImage(with: configuration)
        }
    }
}
