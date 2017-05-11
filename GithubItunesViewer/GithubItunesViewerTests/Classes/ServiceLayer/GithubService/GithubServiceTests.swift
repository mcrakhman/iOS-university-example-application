//
//  GithubServiceTests.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 11.05.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import XCTest

class GithubServiceTests: XCTestCase {

    let defaultTimeout = 0.1

    var mapper: MapperMock!
    var networkClient: NetworkClientMock!
    var deserializer: DeserializerMock!
    var urlBuilder: URLBuilderMock!
    var requestBuilder: RequestBuilderMock!
    var githubService: GithubService!

    override func setUp() {
        super.setUp()
        mapper = MapperMock()
        networkClient = NetworkClientMock()
        deserializer = DeserializerMock()
        urlBuilder = URLBuilderMock()
        requestBuilder = RequestBuilderMock()
        githubService = GithubServiceImplementation(
            mapper: mapper,
            networkClient: networkClient,
            deserializer: deserializer,
            urlBuilder: urlBuilder,
            requestBuilder: requestBuilder
        )
    }

    override func tearDown() {
        super.tearDown()
    }

    func testThatServiceWorksCorrectlyWithConfiguration() {

        // given
        let testExpectation = expectation(description: "Github service completed its job")
        let configuration = GithubRepositorySearchConfiguration(searchString: "someString")

        // when
        githubService.updateRepositories(with: configuration) { response in
            testExpectation.fulfill()
            do {
                _ = try response()
            } catch {}
        }

        waitForExpectations(timeout: defaultTimeout) { _ in
            XCTAssertTrue(self.urlBuilder.buildCalled)
            XCTAssertTrue(self.requestBuilder.buildCalled)
            XCTAssertTrue(self.networkClient.performCalled)
            XCTAssertTrue(self.deserializer.deserializeCalled)
            XCTAssertTrue(self.mapper.mapCalled)
        }
    }

    func testThatURLBuilderErrorResultsInServiceError() {

        // given
        let testExpectation = expectation(description: "Github returned url builder error")
        let configuration = GithubRepositorySearchConfiguration(searchString: "someString")
        urlBuilder.shouldThrowError = true

        // when
        var expectedError: Error?

        githubService.updateRepositories(with: configuration) { response in
            testExpectation.fulfill()
            do {
                _ = try response()
            } catch let error {
                expectedError = error
            }
        }

        waitForExpectations(timeout: defaultTimeout) { _ in
            XCTAssertTrue(self.urlBuilder.buildCalled)
            XCTAssertTrue(expectedError as? NetworkRequestError == .urlConfigurationParserNotImplemented)
            XCTAssertFalse(self.requestBuilder.buildCalled)
            XCTAssertFalse(self.networkClient.performCalled)
            XCTAssertFalse(self.deserializer.deserializeCalled)
            XCTAssertFalse(self.mapper.mapCalled)
        }
    }

    func testThatNetworkErrorResultsInServiceError() {

        // given
        let testExpectation = expectation(description: "Github service returned network client error")
        let configuration = GithubRepositorySearchConfiguration(searchString: "someString")
        networkClient.shouldThrowError = true

        // when
        var expectedError: Error?

        githubService.updateRepositories(with: configuration) { response in
            testExpectation.fulfill()
            do {
                _ = try response()
            } catch let error {
                expectedError = error
            }
        }

        waitForExpectations(timeout: defaultTimeout) { _ in
            XCTAssertTrue(self.urlBuilder.buildCalled)
            XCTAssertTrue(self.requestBuilder.buildCalled)
            XCTAssertTrue(self.networkClient.performCalled)
            XCTAssertTrue(expectedError as? NetworkClientError == .emptyDataReturned)
            XCTAssertFalse(self.deserializer.deserializeCalled)
            XCTAssertFalse(self.mapper.mapCalled)
        }
    }

    func testThatDeserializerErrorResultsInServiceError() {

        // given
        let testExpectation = expectation(description: "Github service returned deserializer error")
        let configuration = GithubRepositorySearchConfiguration(searchString: "someString")
        deserializer.shouldThrowError = true

        // when
        var expectedError: Error?

        githubService.updateRepositories(with: configuration) { response in
            testExpectation.fulfill()
            do {
                _ = try response()
            } catch let error {
                expectedError = error
            }
        }

        waitForExpectations(timeout: defaultTimeout) { _ in
            XCTAssertTrue(self.urlBuilder.buildCalled)
            XCTAssertTrue(self.requestBuilder.buildCalled)
            XCTAssertTrue(self.networkClient.performCalled)
            XCTAssertTrue(self.deserializer.deserializeCalled)
            XCTAssertTrue(expectedError as? MockError == .error)
            XCTAssertFalse(self.mapper.mapCalled)
        }
    }

    // MARK: Mocks

    class MapperMock: GithubMapper {
        var mapCalled = false

        func mapRepositoryArray(_ data: Any) -> [GithubRepository] {
            mapCalled = true
            return []
        }
    }

    class URLBuilderMock: URLBuilder {
        let defaultUrl = URL(string: "some.url")!
        var buildCalled = false
        var shouldThrowError = false

        func build(withAPIPath path: NetworkRequestConstants.APIPath,
                   APIMethod method: NetworkRequestConstants.APIMethodName,
                   configuration: URLBuilderConfiguration) throws -> URL {
            buildCalled = true
            if shouldThrowError {
                throw NetworkRequestError.urlConfigurationParserNotImplemented
            }

            return defaultUrl
        }
    }

    class RequestBuilderMock: RequestBuilder {
        var buildCalled = false

        func build(_ configuration: RequestBuilderConfiguration) -> URLRequest {
            buildCalled = true

            return URLRequest(url: configuration.url)
        }
    }

    class DeserializerMock: Deserializer {
        var deserializeCalled = false
        var shouldThrowError = false

        func deserialize(data: Data) throws -> Any {
            deserializeCalled = true
            if shouldThrowError {
                throw MockError.error
            }

            return [:]
        }
    }

    class NetworkClientMock: NetworkClient {
        var performCalled = false
        var shouldThrowError = false

        func perform(request: URLRequest, completion: NetworkClientCompletion?) {
            performCalled = true

            guard !shouldThrowError else {
                completion! { void in
                    throw NetworkClientError.emptyDataReturned
                }
                return
            }

            completion! { void in
                return Data()
            }
        }

        func data(from url: URL, completion: NetworkClientCompletion?) {}
    }
}
