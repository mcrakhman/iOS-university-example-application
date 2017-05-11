//
//  JSONDeserializerTests.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 11.05.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import XCTest

class JSONDeserializerTests: XCTestCase {

    var deserializer: JSONDeserializer!

    override func setUp() {
        super.setUp()
        deserializer = JSONDeserializer()
    }

    override func tearDown() {
        deserializer = nil
        super.tearDown()
    }

    func testThatDeserializerCorrectlyParsesValidData() {
        // given
        let expectedKey = "ABC"
        let expectedValue = 1
        let object = [expectedKey : expectedValue]
        let data = (try? JSONSerialization.data(withJSONObject: object,
                                                options: .prettyPrinted)) ?? Data()
        // when
        let deserializedObject = try? deserializer.deserialize(data: data)

        // then
        let dictionary = deserializedObject as? [String: Int]
        XCTAssertTrue(dictionary?[expectedKey] == expectedValue)
    }
}
