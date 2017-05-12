//
//  RequestFactoryTests.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 12.05.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import XCTest

class RequestFactoryTests: XCTestCase {

    var requestFactory: RequestFactory!

    override func setUp() {
        super.setUp()
        requestFactory = RequestFactoryImplementation()
    }

    override func tearDown() {
        requestFactory = nil
        super.tearDown()
    }

    func testThatFactoryCreatesCorrectRequestFromConfiguration() {

        // given
        let expectedMethod = NetworkRequestConstants.HTTPMethod.GET
        let expectedTimeoutInterval = 60.0
        let expectedURL = URL(string: "url.url")!
        let configuration = RequestFactoryConfiguration(method: expectedMethod,
                                                        timoutInterval: expectedTimeoutInterval,
                                                        url: expectedURL)

        // when
        let request = requestFactory.create(configuration)

        // then
        XCTAssertTrue(request.url == expectedURL)
        XCTAssertTrue(request.allHTTPHeaderFields?[NetworkRequestConstants.HeaderName.contentType.rawValue] == "application/json")
        XCTAssertTrue(request.allHTTPHeaderFields?[NetworkRequestConstants.HeaderName.accept.rawValue] == "application/json")
        XCTAssertTrue(request.timeoutInterval == expectedTimeoutInterval)
        XCTAssertTrue(request.httpMethod == expectedMethod.rawValue)
    }
}
