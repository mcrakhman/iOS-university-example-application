//
//  ImageDownloaderServiceImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class ImageDownloaderServiceImplementation: ImageDownloaderService {
    let networkClient: NetworkClient
    let queue = DispatchQueue.global()
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func downloadImage(with url: URL, completion: @escaping (UIImage) -> ()) {
        networkClient.data(from: url) { [weak self] response in
            guard let data = try? response(),
                  let strongSelf = self else {
                    return
            }
            
            strongSelf.queue.async {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
}
