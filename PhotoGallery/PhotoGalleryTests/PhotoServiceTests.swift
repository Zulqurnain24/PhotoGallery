//
//  PhotoServiceTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import XCTest
@testable import PhotoGallery

class PhotoServiceTests: XCTestCase {

    // MARK: - Properties

    var service: PhotoService!
    var mockNetworkManager: MockNetworkManager!

    // MARK: - Setup & Teardown

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkManager = MockNetworkManager()
        service = PhotoService(networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        service = nil
        mockNetworkManager = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests

    func testFetchPhotos_Success() async throws {
        // Arrange
        let expectedPhotos = [Photo.mock1()]
        let jsonData = try! JSONEncoder().encode(expectedPhotos)
        mockNetworkManager.data = jsonData

        // Act
        let photos = try await service.fetchPhotos(page: 1, limit: 10)
        XCTAssertEqual(photos.count, 1)
        XCTAssertEqual(photos, [Photo.mock1()])
    }

    func testFetchPhotos_InvalidURL() async {
        // Arrange
        mockNetworkManager.error = PhotoGalleryError.networkError("Invalid URL")

        // Act
        let expectation = XCTestExpectation(description: "Fetch photos failed with invalid URL")
        do {
            let photos = try await service.fetchPhotos(page: 1, limit: 10)
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertEqual(error as? PhotoGalleryError, PhotoGalleryError.networkError("Invalid URL"))
            expectation.fulfill()
        }
    }

    // Add more test cases as needed
}

// MARK: - MockNetworkManager

class MockNetworkManager: NetworkManageable {

    var data: Data?
    var error: Error?

    init(data: Data? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }

    func fetchData(from url: URL) async throws -> Data {
        if let error = error {
            throw error
        } else if let data = data {
            return data
        } else {
            fatalError("No data or error provided for NetworkManager")
        }
    }
}

