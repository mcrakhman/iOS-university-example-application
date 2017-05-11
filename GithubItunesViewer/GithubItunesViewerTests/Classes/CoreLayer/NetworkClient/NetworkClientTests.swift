//
//  NetworkClientTests.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 11.05.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import XCTest

enum MockError: Error {
    case error
}

class NetworkClientTests: XCTestCase {

    let defaultTimeout = 0.1

    var networkClient: NetworkClientImplementation!
    var urlSessionMock: MockURLSession!
    var dataTask: MockDataTask!

    override func setUp() {
        dataTask = MockDataTask()
        urlSessionMock = MockURLSession(dataTask: dataTask)
        networkClient = NetworkClientImplementation(session: urlSessionMock)

        super.setUp()
    }

    override func tearDown() {
        urlSessionMock = nil
        networkClient = nil
        super.tearDown()
    }

    func testThatNetworkClientReturnsDataIfSoDoesURLSession() {

        // given
        let expectedData = Data()
        let request = newMockRequest()
        urlSessionMock.data = expectedData

        let testExpectation = expectation(description: "No error expected")
        var returnedResult: Data?

        // when
        networkClient.perform(request: request) { result in
            do {
                returnedResult = try result()
                testExpectation.fulfill()
            } catch {}
        }

        // then
        waitForExpectations(timeout: 0.1) { _ in
            XCTAssertEqual(returnedResult, expectedData)
            XCTAssertEqual(self.urlSessionMock.inputURLRequest, request)
            XCTAssertTrue(self.dataTask.resumeCalled)
        }
    }

    func testThatEmptyDataFromServerResultsInError() {

        // given
        let expectedError = NetworkClientError.emptyDataReturned
        let request = newMockRequest()
        let testExpectation = expectation(description: "Error Expectation")

        var returnedError: Error?

        // when
        networkClient.perform(request: request) { result in
            do {
                _ = try result()
            } catch let error {
                returnedError = error
                testExpectation.fulfill()
            }
        }

        // then
        waitForExpectations(timeout: defaultTimeout) { _ in
            XCTAssertEqual(returnedError as? NetworkClientError, expectedError)
            XCTAssertEqual(self.urlSessionMock.inputURLRequest, request)
            XCTAssertTrue(self.dataTask.resumeCalled)
        }
    }

    func testThatErrorFromServerResultsInError() {
        // given
        let expectedError = MockError.error
        urlSessionMock.error = expectedError

        let request = newMockRequest()
        let testExpectation = expectation(description: "Error Expectation")
        var returnedError: Error?

        // when
        networkClient.perform(request: request) { result in
            do {
                _ = try result()
            } catch let error {
                returnedError = error
                testExpectation.fulfill()
            }
        }

        // then
        waitForExpectations(timeout: defaultTimeout) { _ in
            XCTAssertEqual(returnedError as? MockError, expectedError)
            XCTAssertEqual(self.urlSessionMock.inputURLRequest, request)
            XCTAssertTrue(self.dataTask.resumeCalled)
        }
    }

    private func newMockRequest() -> URLRequest {
        let url = URL(string: "www.youaresocool.com")!
        let request = URLRequest(url: url)

        return request
    }

    // MARK: Mocks

    class MockDataTask: URLSessionDataTask {
        var resumeCalled = false

        override func resume() {
            resumeCalled = true
        }
    }

    class MockURLSession: URLSession {

        var inputURLRequest: URLRequest?
        var data: Data?
        var urlResponse: URLResponse?
        var error: Error?

        let dataTask: MockDataTask

        init(dataTask: MockDataTask) {
            self.dataTask = dataTask
        }

        override func dataTask(with request: URLRequest,
                               completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            inputURLRequest = request
            completionHandler(data, urlResponse, error)

            return dataTask
        }
    }
}
