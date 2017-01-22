//
//  ImageDownloaderConfiguration.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

struct ImageDownloaderConfiguration {
    let url: URL
    let completion: (UIImage) -> ()
}
