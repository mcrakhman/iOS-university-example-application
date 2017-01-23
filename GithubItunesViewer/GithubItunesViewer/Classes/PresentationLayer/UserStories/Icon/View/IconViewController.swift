//
//  IconViewController.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 23.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class IconViewController: UIViewController, IconViewInput {
    
    @IBOutlet weak var iconImageView: UIImageView!
    var output: IconViewOutput?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewIsReady()
    }
    
    func imageTap(_ tap: UITapGestureRecognizer) {
        output?.didTapImage()
    }
    
    func setupInitialState(with image: UIImage) {
        iconImageView.image = image
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageTap))
        view.addGestureRecognizer(recognizer)
    }
}
