//
//  ImageCellDelegate.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol ImageCellDelegate: class, CellDelegate {
    func downloadImage(with configuration: ImageDownloaderConfiguration)
}
