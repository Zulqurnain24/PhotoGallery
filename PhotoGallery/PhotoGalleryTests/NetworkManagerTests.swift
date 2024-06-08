//
//  NetworkManagerTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import Foundation
import XCTest
@testable import PhotoGallery

class NetworkManagerTests: XCTestCase {

    func testFetchDataSuccess() async {
        // Given
        let expectedData = "Mock data".data(using: .utf8)!

        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: sessionConfiguration)
        let networkManager = await NetworkManager(urlSession: mockSession)
        let url = URL(string: "https://example.com")!
        URLProtocolMock.mockURLs = [url: (nil, expectedData, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: [:]))]
        // When
        do {
            let data = try await networkManager.fetchData(from: url)

            // Then
            XCTAssertEqual(data, expectedData)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchDataFailure() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: 404, userInfo: nil)
        let mockSession = MockURLSession()
        let networkManager = NetworkManager(urlSession: mockSession)
        let url = URL(string: "www.invaidurl.")!
        URLProtocolMock.mockURLs = [url: (expectedError, Data(), HTTPURLResponse(url: url, statusCode: expectedError.code, httpVersion: nil, headerFields: [:]))]
        // When
        do {
            _ = try await networkManager.fetchData(from: url)

            // Then
            XCTFail("Expected error was not thrown")
        } catch {
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (PhotoGallery.PhotoGalleryError error 0.)")
        }
    }
}
class MockURLSession: URLSession {
    var data: Data?
    var error: Error?
    var response: URLResponse?

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = MockURLSessionDataTask()
        task.completionHandler = completionHandler
        DispatchQueue.global().async {
            if let error = self.error {
                completionHandler(nil, nil, error)
            } else {
                completionHandler(self.data, self.response, nil)
            }
        }
        return task
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    override func resume() {}

    override func cancel() {}
}

class URLProtocolMock: URLProtocol {
    /// Dictionary maps URLs to tuples of error, data, and response
    static var mockURLs = [URL?: (error: Error?, data: Data?, response: HTTPURLResponse?)]()

    override class func canInit(with request: URLRequest) -> Bool {
        // Handle all types of requests
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Required to be implemented here. Just return what is passed
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let (error, data, response) = URLProtocolMock.mockURLs[url] {

                // We have a mock response specified so return it.
                if let responseStrong = response {
                    self.client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
                }

                // We have mocked data specified so return it.
                if let dataStrong = data {
                    self.client?.urlProtocol(self, didLoad: dataStrong)
                }

                // We have a mocked error so return it.
                if let errorStrong = error {
                    self.client?.urlProtocol(self, didFailWithError: errorStrong)
                }
            }
        }

        // Send the signal that we are done returning our mock response
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // Required to be implemented. Do nothing here.
    }
}
