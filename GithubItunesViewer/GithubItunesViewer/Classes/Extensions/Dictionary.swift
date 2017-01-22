//
//  Dictionary.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

extension Dictionary {
    subscript(stringDict key: Key) -> [String: Any]? {
        get {
            return self[key] as? [String: Any]
        }
        set {
            self[key] = newValue as? Value
        }
    }
    
    subscript(stringDictArray key: Key) -> [[String: Any]]? {
        get {
            return self[key] as? [[String: Any]]
        }
        set {
            self[key] = newValue as? Value
        }
    }
}
