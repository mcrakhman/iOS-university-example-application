//
//  CoreAssembly.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

protocol CoreAssembly {
    func githubMapper() -> GithubMapper
    func iTunesMapper() -> ITunesMapper
    func networkClient() -> NetworkClient
    func urlBuilder() -> URLBuilder
    func requestBuilder() -> RequestBuilder
    func jsonDeserializer() -> Deserializer
}
