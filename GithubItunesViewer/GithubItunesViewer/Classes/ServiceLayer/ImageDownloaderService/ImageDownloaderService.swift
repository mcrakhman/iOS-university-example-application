//
//  ImageDownloaderService.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

protocol ImageDownloaderService: class {
    func downloadImage(with url: URL, completion: @escaping (UIImage) -> ())
}
