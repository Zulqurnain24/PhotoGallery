//
//  PhotoDetailViewModelTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 19/05/2024.
//

import XCTest
@testable import PhotoGallery

class PhotoDetailViewModelTests: XCTestCase {

    var photo: Photo!
    var sut: PhotoDetailViewModel!

    override func setUp() {
        super.setUp()
        photo = Photo.mock1()
        sut = PhotoDetailViewModel(photo: photo, persistenceStoreManager: MockFactory.createPersistentStoreManager())
    }

    override func tearDown() {
        photo = nil
        sut = nil
        super.tearDown()
    }

    func testAddToFavourites() {
        // Given
        sut.addToFavourites(photo)
        
        // When
        let favouritesList = sut.persistenceStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self)

        // Then
        XCTAssertTrue(favouritesList?.contains(photo) ?? false)
    }

    func testRemoveFromFavourites() {
        // Given
        sut.addToFavourites(photo)
        sut.removeFromFavourites(photo)

        // When
        let favourites = sut.persistenceStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self)

        // Then
        XCTAssertFalse(favourites?.contains(photo) ?? false)
    }

    func testIsImageFavourite() {
        // Given
        sut.addToFavourites(photo)
        XCTAssertTrue(sut.isImageFavourite())

        // When
        sut.removeFromFavourites(photo)

        // Then
        XCTAssertFalse(sut.isImageFavourite())
    }
}
