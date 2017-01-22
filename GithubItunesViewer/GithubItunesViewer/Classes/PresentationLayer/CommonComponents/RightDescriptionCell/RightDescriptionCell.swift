//
//  RightDescriptionCell.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class RightDescriptionCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var titleLabelSupreviewTrailing: NSLayoutConstraint!
    @IBOutlet weak var supreviewTitleLabelLeading: NSLayoutConstraint!
    
    func configure(with viewModel: CellViewModel, delegate: CellDelegate?) {
        guard let viewModel = viewModel as? GithubRepositoryViewModel else {
            return
        }
        iconImageView.image = UIImage.placeholder
        descriptionLabel?.text = viewModel.userUrl?.relativeString
        titleLabel?.text = viewModel.login
        
        if let delegate = delegate as? ImageCellDelegate,
            let url = viewModel.imageUrl {
            
            let completion: (UIImage) -> () = { [weak self] image in
                self?.iconImageView.image = image
            }
            let configuration = ImageDownloaderConfiguration(url: url, completion: completion)
            delegate.downloadImage(with: configuration)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = contentView.frame.width - titleLabelSupreviewTrailing.constant - supreviewTitleLabelLeading.constant
        
        descriptionLabel.preferredMaxLayoutWidth = width
        titleLabel.preferredMaxLayoutWidth = width
    }
    
}
