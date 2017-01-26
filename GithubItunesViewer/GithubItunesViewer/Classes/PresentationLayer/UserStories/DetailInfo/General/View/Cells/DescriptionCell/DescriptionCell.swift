//
//  DescriptionCell.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var titleLabelSupreviewTrailing: NSLayoutConstraint!
    @IBOutlet weak var supreviewTitleLabelLeading: NSLayoutConstraint!
    
    weak var delegate: ImageCellDelegate?
    
    func configure(with viewModel: CellViewModel, delegate: CellDelegate?) {
        guard let viewModel = viewModel as? EntryDescriptionViewModel else {
            return
        }
        iconImageView.image = UIImage.placeholder
        descriptionLabel?.text = viewModel.description
        titleLabel?.text = viewModel.title
        
        if let delegate = delegate as? ImageCellDelegate,
            let url = viewModel.imageUrl {
            
            self.delegate = delegate
            
            let completion: (UIImage) -> () = { [weak self] image in
                self?.iconImageView.contentMode = .scaleAspectFill
                self?.iconImageView.image = image
            }
            let configuration = ImageDownloaderConfiguration(url: url, completion: completion)
            delegate.downloadImage(with: configuration)
        }
    }
    
    override func awakeFromNib() {
        if iconImageView.gestureRecognizers == nil {
            addRecognizer()
        }
    }
    
    func tapImage() {
        guard let image = iconImageView.image else {
            return
        }
        
        let frame = contentView.convert(iconImageView.frame, to: nil)
        let configuration = ImageTransitionConfiguration(image: image, frame: frame)
        
        delegate?.didReceiveImageTransition(configuration)
    }
    
    func addRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        iconImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = contentView.frame.width - titleLabelSupreviewTrailing.constant - supreviewTitleLabelLeading.constant
        
        descriptionLabel.preferredMaxLayoutWidth = width
        titleLabel.preferredMaxLayoutWidth = width
    }
}
