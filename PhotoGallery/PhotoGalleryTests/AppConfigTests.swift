//
//  AppConfigTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import XCTest
@testable import PhotoGallery

class AppConfigTests: XCTestCase {

    func testAppConfigValues() {
        XCTAssertEqual(AppConfig.baseURL, "https://jsonplaceholder.typicode.com/photos")
        XCTAssertEqual(AppConfig.prefetchPages, 10)
        XCTAssertEqual(AppConfig.pageLimit, 5)
        XCTAssertEqual(AppConfig.imageLoadError, "Unable to load image from")
        XCTAssertEqual(AppConfig.removeButtonStatus, "Remove from Favorites")
        XCTAssertEqual(AppConfig.addtoFavouriteButtonStatus, "Add to Favorites")
        XCTAssertEqual(AppConfig.favouriteList, "favouriteList")
        XCTAssertEqual(AppConfig.photoDetail, "Photo Detail")
        XCTAssertEqual(AppConfig.galleryTitle, "Gallery")
        XCTAssertEqual(AppConfig.favouritesTitle, "Favourites")
        XCTAssertEqual(AppConfig.galleryTabImage, "photo.on.rectangle")
        XCTAssertEqual(AppConfig.favouriteTabImage, "heart.fill")
        XCTAssertEqual(AppConfig.trashImage, "trash")
        XCTAssertEqual(AppConfig.gridCellSize, CGFloat(100))
        XCTAssertEqual(AppConfig.gridCellImageSize, CGFloat(120))
        XCTAssertEqual(AppConfig.gridCellSpacing, CGFloat(5.0))
        XCTAssertEqual(AppConfig.scrollViewPadding, CGFloat(5.0))
        XCTAssertEqual(AppConfig.thumbnailSize, CGFloat(50.0))
        XCTAssertEqual(AppConfig.thumbnailCellCornerRadius, CGFloat(5.0))
        XCTAssertEqual(AppConfig.errorFetchingPhotos, "Error fetching photos:")
        XCTAssertEqual(AppConfig.errorPreFetchingPhotos, "Error fetching photos:")
        XCTAssertEqual(AppConfig.unableToEncodeValue, "Error: Unable to encode the value")
        XCTAssertEqual(AppConfig.clearDataForKey, "clear data for key")
        XCTAssertEqual(AppConfig.notConnectedToInternet, "Not connected to network")
        XCTAssertEqual(AppConfig.failedToDecodeCacheImages, "Failed to decode cached photos:")
        XCTAssertEqual(AppConfig.fetchingImagesForPage, "Fetching photos for page")
        XCTAssertEqual(AppConfig.withLimit, "with limit")
    }

    func testPrintPersistentEncodableObject() {
        let result = AppConfig.printPersistentEncodableObject(key: "testKey", value: "testValue")
        XCTAssertEqual(result, "encodeAndSave<T: Encodable>(_ key: testKey, value: testValue")
    }

    func testPrintPersistentDecodableObject() {
        let result = AppConfig.printPersistentDecodableObject(key: "testKey", value: "testValue")
        XCTAssertEqual(result, "Unable to decode the value - getAndDecode<T: Decodable>(_ key: testKey, _ type: testValue")
    }
}


