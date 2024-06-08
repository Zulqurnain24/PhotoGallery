//
//  FavouritesViewModelTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import XCTest
@testable import PhotoGallery

class FavouritesViewModelTests: XCTestCase {

    var sut: FavouritesViewModel?

    override func setUp() async throws {
        sut = MockFactory.createFavouritesViewModel(persistenceStoreManager:  MockFactory.createPersistentStoreManager())
    }

    func testRemoveFromFavourites() {
        // Given
        sut?.persistentStoreManager.encodeAndSave(AppConfig.favouriteList, value: [Photo.mock1(), Photo.mock2()])

        // When
        sut?.removeFromFavourites(Photo.mock2())

        // Then
        let favouriteList: [Photo] = sut?.persistentStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self) ?? []
        XCTAssertEqual(favouriteList, [PhotoGallery.Photo(id: 1, albumId: 1, title: "Mocked Title 1", url: "Mocked URL 1", thumbnailUrl: "Mocked Thumbnail URL 1")])
    }

    func testPopulateFavouritesList() {
        // Given
        sut?.persistentStoreManager.encodeAndSave(AppConfig.favouriteList, value: [Photo.mock1(), Photo.mock2()])

        // When
        sut?.populateFavouritesList()

        // Then
        let favouriteList: [Photo] = sut?.persistentStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self) ?? []
        XCTAssertEqual(favouriteList, [Photo.mock1(), Photo.mock2()])
    }
}
