//
//  NetworkClient.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

typealias NetworkClientResult = () throws -> Data

typealias NetworkClientCompletion = (_ result: @escaping NetworkClientResult) -> Void

protocol NetworkClient {
    func perform(request: URLRequest, completion: NetworkClientCompletion?)
    func data(from url: URL, completion: NetworkClientCompletion?)
}
