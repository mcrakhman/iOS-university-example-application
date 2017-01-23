//
//  GithubViewOutput.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol GithubViewOutput: class {
    func viewIsReady()
    func didAskToDownloadImage(with configuration: ImageDownloaderConfiguration)
    func didAskToTransition(with configuration: ImageTransitionConfiguration)
    func didTapRepeatButton()
}
