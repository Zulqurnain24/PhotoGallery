//
//  ImageCacheManagerTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import XCTest
@testable import PhotoGallery

class ImageCacheManagerTests: XCTestCase {

    // MARK: - Properties

    var cacheManager: ImageCacheManager!
    let testImageURL = URL(string: "https://example.com/testImage.png")!

    // MARK: - Setup & Teardown

    override func setUpWithError() throws {
        try super.setUpWithError()
        cacheManager = ImageCacheManager.shared
    }

    override func tearDownWithError() throws {
        cacheManager = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests

    func testImageCaching() {
        // Arrange
        let testImage = UIImage(named: "placeholder")!

        // Act
        cacheManager.save(testImage, for: testImageURL)

        // Assert
        XCTAssertNotNil(cacheManager.image(for: testImageURL), "Cached image should not be nil")
    }

    func testImageRetrieval() {
        // Arrange
        let testImage = UIImage(named: "placeholder")!

        // Act
        cacheManager.save(testImage, for: testImageURL)
        let cachedImage = cacheManager.image(for: testImageURL)

        // Assert
        XCTAssertNotNil(cachedImage, "Retrieved image should not be nil")
        XCTAssertEqual(cachedImage, testImage, "Retrieved image should be equal to original image")
    }

    func testImageDiskStorage() {
        // Arrange
        let testImage = UIImage(named: "placeholder")!

        // Act
        cacheManager.save(testImage, for: testImageURL)
        let loadedImage = cacheManager.image(for: testImageURL)

        // Assert
        XCTAssertNotNil(loadedImage, "Loaded image should not be nil")
        XCTAssertEqual(loadedImage, testImage, "Loaded image should be equal to original image")
    }

    func testImageNonExistentURL() {
        // Act & Assert
        XCTAssertNil(cacheManager.image(for: URL(string: "https://example.com/nonExistentImage.png")!), "Non-existent image URL should return nil")
    }
}

