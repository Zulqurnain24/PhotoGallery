//
//  MockFactoryTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 19/05/2024.
//

import XCTest
@testable import PhotoGallery

class MockFactoryTests: XCTestCase {

    // MARK: - GridCellView Tests

    func testCreateGridCellView() {
        // Given
        let photo = Photo.mock1()

        // When
        let gridCellView = MockFactory.createGridCellView(photo: photo)

        // Then
        XCTAssertNotNil(gridCellView)
        XCTAssertEqual(gridCellView.photo, photo)
    }

    // MARK: - PhotoDetailView Tests

    func testCreatePhotoDetailView() {
        // Given
        let photo = Photo.mock1()
        let isFavorite = true

        // When
        let photoDetailView = MockFactory.createPhotoDetailView(photo: photo, isFavorite: isFavorite)

        // Then
        XCTAssertNotNil(photoDetailView)
        XCTAssertEqual(photoDetailView.viewModel.photo, photo)
        XCTAssertEqual(photoDetailView.isFavorite, isFavorite)
    }

    // MARK: - PhotoDetailViewModel Tests

    func testCreatePhotoDetailViewModel() {
        // Given
        let photo = Photo.mock1()

        // When
        let photoDetailViewModel = MockFactory.createPhotoDetailViewModel(photo: photo)

        // Then
        XCTAssertNotNil(photoDetailViewModel)
        XCTAssertEqual(photoDetailViewModel.photo, photo)
    }

    // MARK: - FavouritesViewModel Tests

    func testCreateFavouritesViewModel() {
        // When
        let favouritesViewModel = MockFactory.createFavouritesViewModel()

        // Then
        XCTAssertNotNil(favouritesViewModel)
    }

    // MARK: - PhotoGalleryViewModel Tests

    func testCreatePhotoGalleryViewModel() {
        // When
        let photoGalleryViewModel = MockFactory.createPhotoGalleryViewModel()

        // Then
        XCTAssertNotNil(photoGalleryViewModel)
    }

    // MARK: - Logger Tests

    func testCreateLogger() {
        // When
        let logger = MockFactory.createLogger()

        // Then
        XCTAssertNotNil(logger)
    }

    // MARK: - MainView Tests

    func testCreateMainView() {
        // When
        let mainView = MockFactory.createMainView()

        // Then
        XCTAssertNotNil(mainView)
    }

    // MARK: - GalleryView Tests

    func testCreateGalleryView() {
        // When
        let galleryView = MockFactory.createGalleryView()

        // Then
        XCTAssertNotNil(galleryView)
    }

    // MARK: - FavouritesView Tests

    func testCreateFavouritesView() {
        // When
        let favouritesView = MockFactory.createFavouritesView()

        // Then
        XCTAssertNotNil(favouritesView)
    }

    // MARK: - PhotoView Tests

    func testCreatePhotoView() {
        // Given
        let urlString = "https://example.com/photo.jpg"

        // When
        let photoView = MockFactory.createPhotoView(urlString: urlString)

        // Then
        XCTAssertNotNil(photoView)
        XCTAssertEqual(photoView.urlString, urlString)
    }

    // MARK: - PhotoDetailView Tests

    func testCreatePhotoDetailViewWithPhoto() {
        // Given
        let photo = Photo.mock1()

        // When
        let photoDetailView = MockFactory.createPhotoDetailView(photo: photo)

        // Then
        XCTAssertNotNil(photoDetailView)
        XCTAssertEqual(photoDetailView.viewModel.photo, photo)
    }

    // MARK: - PhotoRepositoryProtocol Tests

    func testCreatePhotoRepository() {
        // When
        let photoRepository = MockFactory.createPhotoRepository()

        // Then
        XCTAssertNotNil(photoRepository)
    }

    // MARK: - PhotoServiceProtocol Tests

    func testCreatePhotoService() {
        // When
        let photoService = MockFactory.createPhotoService()

        // Then
        XCTAssertNotNil(photoService)
    }

    // MARK: - NetworkManageable Tests

    func testCreateNetworkManager() {
        // When
        let networkManager = MockFactory.createNetworkManager()

        // Then
        XCTAssertNotNil(networkManager)
    }

    func testCreateNetworkManagerWithResponse() {
        // Given
        let responseData = Data()
        let error = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)

        // When
        let networkManager = MockFactory.createNetworkManager(response: (responseData, error))

        // Then
        XCTAssertNotNil(networkManager)
        XCTAssertEqual(networkManager.mockData, responseData)
        XCTAssertEqual(networkManager.mockError as NSError?, error)
    }

    // MARK: - PersistentStoreManageable Tests

    func testCreatePersistentStoreManager() {
        // When
        let persistentStoreManager = MockFactory.createPersistentStoreManager()

        // Then
        XCTAssertNotNil(persistentStoreManager)
    }
}
