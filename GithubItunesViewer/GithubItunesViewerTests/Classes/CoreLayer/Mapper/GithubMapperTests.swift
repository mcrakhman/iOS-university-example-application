//
//  GithubMapperTests.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 11.05.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import XCTest

class GithubMapperTests: XCTestCase {

    var mapper: GithubMapper!

    override func setUp() {
        super.setUp()
        mapper = GithubMapperImplementation()
    }

    override func tearDown() {
        mapper = nil
        super.tearDown()
    }

    func testThatMapperMapsGithubObjectsCorrectly() {

        // given
        let expectedRepositoryUrlString = "abcd.ru"
        let expectedAvatarUrlString = "avatar.ru"
        let expectedLogin = "login"

        let json =
            ["items":
                [
                    ["owner":
                        [
                            "url": expectedRepositoryUrlString,
                            "avatar_url": expectedAvatarUrlString,
                            "login": expectedLogin
                        ]
                    ]
                ]
            ]

        // when
        let mappedArray = mapper.mapRepositoryArray(json)

        // then
        XCTAssertTrue(mappedArray.count == 1)
        if let entry = mappedArray.first {
            XCTAssertTrue(entry.avatarUrlString == expectedAvatarUrlString)
            XCTAssertTrue(entry.repositoryUrlString == expectedRepositoryUrlString)
            XCTAssertTrue(entry.login == expectedLogin)
        }
    }

    func testThatIncorrectObjectsWillNotBeIncludedInTheArray() {

        // given
        let expectedRepositoryUrlString = "abcd.ru"
        let expectedAvatarUrlString = "avatar.ru"
        let expectedLogin = "login"

        let json =
            ["items":
                [
                    ["owner":
                        [
                            "an_url": expectedRepositoryUrlString,
                            "avatar_url": expectedAvatarUrlString,
                            "login": expectedLogin
                        ]
                    ]
                ]
        ]

        // when
        let mappedArray = mapper.mapRepositoryArray(json)

        // then
        XCTAssertTrue(mappedArray.count == 0)
    }
}
