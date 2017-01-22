//
//  ThrottlerImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class ThrottlerImplementation: Throttler {
    var timer = Timer()
    var completion: (() -> ())?
    
    func throttle(_ delay: TimeInterval, completion: @escaping () -> ()) {
        timer.invalidate()
        self.completion = completion
        timer = Timer(timeInterval: delay,
                      target: self,
                      selector: #selector(fire),
                      userInfo: nil,
                      repeats: true)
        RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
    }

    @objc func fire() {
        completion?()
        completion = nil
    }
}
