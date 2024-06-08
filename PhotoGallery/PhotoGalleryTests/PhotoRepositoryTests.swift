//
//  PhotoRepositoryTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import Foundation
import XCTest
@testable import PhotoGallery

class PhotoRepositoryTests: XCTestCase {
    var sut: PhotoRepository!
    var mockPhotoService: PhotoServiceProtocol!

    override func setUp() {
        super.setUp()
        mockPhotoService = MockFactory.createPhotoService()
        sut = PhotoRepository(service: mockPhotoService, persistentStoreManager: MockFactory.createPersistentStoreManager(), networkMonitor: MockNWPathMonitor(status: .satisfied))
    }

    override func tearDown() {
        sut = nil
        mockPhotoService = nil
        super.tearDown()
    }

    func testGetPhotosViaService_whenSuccessFul() async throws {
        // Given
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode([Photo.mock1()])
        let mockNetworkManager = MockFactory.createNetworkManager(response: (jsonData, nil))
        let mockPhotoService = PhotoService(networkManager: mockNetworkManager)
        sut = PhotoRepository(service: mockPhotoService, persistentStoreManager: MockPersistentStoreManager.shared, networkMonitor: MockNWPathMonitor(status: .satisfied))

        // When
        let photoList = try await sut?.getPhotos(page: 1, limit: 10)

        // Then
        XCTAssertEqual(photoList, [Photo.mock1()])
    }

    func testGetPhotosViaService_whenUnSuccessFul() async throws {
        // Given
        let mockNetworkManager = MockFactory.createNetworkManager(response: (nil, PhotoGalleryError.networkError("Server not responding")))
        let mockPhotoService = PhotoService(networkManager: mockNetworkManager)
        sut = PhotoRepository(service: mockPhotoService, persistentStoreManager: MockPersistentStoreManager.shared, networkMonitor: MockNWPathMonitor(status: .satisfied))

        // When
        do {
            let photoList = try await sut?.getPhotos(page: 1, limit: 10)
            XCTFail("Unexpected behaviour")
        } catch {
            // Then
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (PhotoGallery.PhotoGalleryError error 0.)")
        }
    }

    func testGetPhotosWithCachedData() async throws {
        // Given
        let photo = Photo.mock1()
        let encodedPhotoData = try JSONEncoder().encode([photo])
        sut.persistentStoreManager.encodeAndSave("1_10", value: encodedPhotoData)

        // When
        let photos = try await sut.getPhotos(page: 1, limit: 10)

        // Then
        XCTAssertEqual(photos.count, 1)
        XCTAssertEqual(photos.first?.id, photo.id)
    }

    func testSavePhotosToCache_whenSuccessful() {
        // Given
        let photo = Photo.mock1()
        sut.savePhotosToCache([photo], forKey: "1_10")

        // When
        let cachedPhotos = MockPersistentStoreManager.shared.getAndDecode("1_10", [Photo].self)

        // Then
        XCTAssertNotNil(cachedPhotos)
        XCTAssertEqual(cachedPhotos?.count, 1)
        XCTAssertEqual(cachedPhotos?.first?.id, photo.id)
    }

    func testSavePhotosToCache_whenUnSuccessful() {
        // Given
        let photo = Photo.mock1()
        sut.savePhotosToCache([photo], forKey: "1_10")

        // When
        let cachedPhotos = MockPersistentStoreManager.shared.getAndDecode("", [Photo].self)

        // Then
        XCTAssertNil(cachedPhotos)
        XCTAssertEqual(cachedPhotos?.count, nil)
        XCTAssertEqual(cachedPhotos?.first?.id, nil)
    }

    func testPrefetchPhotos_whenSuccessful() async throws {
        // Given
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode([Photo.mock1()])
        let mockNetworkManager = MockFactory.createNetworkManager(response: (jsonData, nil))
        let mockPhotoService = PhotoService(networkManager: mockNetworkManager)
        sut = PhotoRepository(service: mockPhotoService, persistentStoreManager: MockPersistentStoreManager.shared, networkMonitor: MockNWPathMonitor(status: .satisfied))

        // When
        try await sut.prefetchPhotos(startingFrom: 1, limit: 10)

        // Then
        let cachedPhotos = MockPersistentStoreManager.shared.getAndDecode("1_10", [Photo].self)

        XCTAssertNotNil(cachedPhotos)
        XCTAssertEqual(cachedPhotos?.count, 10)
        XCTAssertEqual(cachedPhotos?.first?.id, Photo.mock1().id)
    }

    func testPrefetchPhotos_whenUnSuccessful() async throws {
        // Given
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode([Photo.mock1()])
        let mockNetworkManager = MockFactory.createNetworkManager(response: (jsonData, nil))
        let mockPhotoService = PhotoService(networkManager: mockNetworkManager)
        sut = PhotoRepository(service: mockPhotoService, persistentStoreManager: MockPersistentStoreManager.shared, networkMonitor: MockNWPathMonitor(status: .satisfied))

        // When
        try await sut.prefetchPhotos(startingFrom: 1, limit: 10)

        // Then
        let cachedPhotos = MockPersistentStoreManager.shared.getAndDecode("1_20", [Photo].self)

        XCTAssertNil(cachedPhotos)
        XCTAssertEqual(cachedPhotos?.count, nil)
        XCTAssertEqual(cachedPhotos?.first?.id, nil)
    }

    func testGetPhotosFromCache() async throws {
        // Given
        let page: Int = 1
        let limit: Int = 10
        let cacheKey = "\(page)_\(limit)"
        let cachedPhotos: [Photo] = [Photo.mock1(), Photo.mock2()]

        MockPersistentStoreManager.shared.encodeAndSave(cacheKey, value: cachedPhotos)

        let retrievedPhotos = MockPersistentStoreManager.shared.getAndDecode(cacheKey, [Photo].self)
        let networkManager = MockNetworkManager(data: try JSONEncoder().encode(retrievedPhotos))

        sut = PhotoRepository(service: PhotoService(networkManager: networkManager), persistentStoreManager: MockFactory.createPersistentStoreManager(), networkMonitor: MockNWPathMonitor(status: .satisfied))

        let expectation = XCTestExpectation(description: "fetched photos from catch successfully")

        // When
        do {
            let fetchedPhotos = try await sut.getPhotos(page: page, limit: limit)
            // Then
            XCTAssertEqual(fetchedPhotos, cachedPhotos)
            expectation.fulfill()
        } catch {
            XCTFail("Failed to fetch photos from cache")
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
