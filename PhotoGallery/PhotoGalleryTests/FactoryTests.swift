//
//  FactoryTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import XCTest
@testable import PhotoGallery

final class FactoryTests: XCTestCase {

    func testCreatePhotoDetailViewModel() {
        let photo = Photo.mock1()
        let viewModel = Factory.createPhotoDetailViewModel(photo: photo)
        XCTAssertTrue(viewModel is PhotoDetailViewModel)
        XCTAssertEqual(viewModel.photo, photo)
    }

    func testCreateFavouritesViewModel() {
        let viewModel = Factory.createFavouritesViewModel(persistenceStoreManager: PersistentStoreManager.shared)
        XCTAssertTrue(viewModel is FavouritesViewModel)
    }

    func testCreatePhotoGalleryViewModel() {
        let viewModel = Factory.createPhotoGalleryViewModel()
        XCTAssertTrue(viewModel is PhotoGalleryViewModel)
    }

    func testCreateLogger() {
        let logger = Factory.createLogger()
        XCTAssertTrue(logger is Logger)
    }

    func testCreateGalleryView() {
        let galleryView = Factory.createGalleryView()
        XCTAssertTrue(galleryView is GalleryView<PhotoGalleryViewModel>)
    }

    func testCreateFavouritesView() {
        let favouritesView = Factory.createFavouritesView()
        XCTAssertTrue(favouritesView is FavouritesView<FavouritesViewModel>)
    }

    func testCreatePhotoView() {
        let urlString = "https://example.com/photo.jpg"
        let photoView = Factory.createPhotoView(urlString: urlString)
        XCTAssertTrue(photoView is PhotoView)
        XCTAssertEqual(photoView.urlString, urlString)
    }

    func testCreatePhotoDetailView() {
        let photo = Photo.mock1()
        let detailView = Factory.createPhotoDetailView(photo: photo, isFavorite: true)
        XCTAssertTrue(detailView is PhotoDetailView<PhotoDetailViewModel>)
        XCTAssertEqual(detailView.viewModel.photo, photo)
        XCTAssertEqual(detailView.isFavorite, true)
    }

    func testCreateMainView() {
        let mainView = Factory.createMainView()
        XCTAssertTrue(mainView is MainView)
    }

    func testCreatePhotoService() {
        let service = Factory.createPhotoService()
        XCTAssertTrue(service is PhotoService)
    }

    func testCreatePhotoRepository() {
        let repository = Factory.createPhotoRepository()
        XCTAssertTrue(repository is PhotoRepository)
    }

    func testCreateNetworkManager() {
        let networkManager = Factory.createNetworkManager()
        XCTAssertTrue(networkManager is NetworkManager)
    }

    func testCreatePersistentStoreManager() {
        let persistentStoreManager = Factory.createPersistentStoreManager()
        XCTAssertTrue(persistentStoreManager is PersistentStoreManager)
    }

    func testCreateGridCellView() {
        let gridCellView = Factory.createGridCellView(photo: Photo.mock1())
        XCTAssertTrue(gridCellView is GridCellView)
    }

    func testCreateNetworkMonitor() {
        let networkMonitor = Factory.createNetworkMonitor()
        XCTAssertTrue(networkMonitor is NetworkMonitor)
    }
}


