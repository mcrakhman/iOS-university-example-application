//
//  URLFactoryTests.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 12.05.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import XCTest

class URLFactoryTests: XCTestCase {

    var urlFactory: URLFactory!

    override func setUp() {
        super.setUp()
        urlFactory = URLFactoryImplementation()
    }

    override func tearDown() {
        urlFactory = nil
        super.tearDown()
    }

    func testThatURLFactoryCreatesCorrectURLFromGithubConfiguration() {

        // given
        let expectedFirstSearchString = "search"
        let expectedSecondSearchString = "something"
        let configuration = GithubRepositorySearchConfiguration(
            searchString: expectedFirstSearchString + " " + expectedSecondSearchString
        )

        // when
        let url = try? urlFactory.create(withAPIPath: .githubPath,
                                         APIMethod: .githubMethod,
                                         configuration: configuration)

        // then
        let expectedFullUrlString = "https://api.github.com/search/repositories?q="
            + expectedFirstSearchString
            + "+"
            + expectedSecondSearchString
        XCTAssertTrue(url?.absoluteString == expectedFullUrlString)
    }

    func testThatURLFactoryCreatesCorrectURLFromiTunesConfiguration() {

        // given
        let expectedFirstSearchString = "search"
        let expectedSecondSearchString = "something"
        let configuration = ITunesSearchConfiguration(
            searchString: expectedFirstSearchString + " " + expectedSecondSearchString
        )

        // when
        let url = try? urlFactory.create(withAPIPath: .iTunesPath,
                                         APIMethod: .iTunesMethod,
                                         configuration: configuration)

        // then
        let expectedFullUrlString = "https://itunes.apple.com/search?term="
            + expectedFirstSearchString
            + "+"
            + expectedSecondSearchString
        XCTAssertTrue(url?.absoluteString == expectedFullUrlString)
    }

    func testThatIncorrectConfigurationResultsInError() {

        // given
        struct UnknownConfiguration: URLFactoryConfiguration {}

        let configuration = UnknownConfiguration()

        // when
        let url = try? urlFactory.create(withAPIPath: .iTunesPath,
                                         APIMethod: .iTunesMethod,
                                         configuration: configuration)

        // then
        XCTAssertNil(url)
    }
}
