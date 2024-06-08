//
//  MockFactory.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation
import CoreData
import SwiftUI
import Network

class MockFactory: FactoryProtocol {
    static func createNetworkMonitor(status: NWPath.Status = .requiresConnection) -> MockNWPathMonitor {
        MockNWPathMonitor(status: status)
    }
    
    static func createGridCellView(photo: Photo = Photo.mock1()) -> GridCellView {
        GridCellView(photo: photo)
    }

    static func createPhotoDetailView(photo: Photo = .mock1(), isFavorite: Bool = false) -> PhotoDetailView<PhotoDetailViewModel> {
        PhotoDetailView(viewModel: PhotoDetailViewModel(photo: photo), isFavorite: isFavorite)
    }
    
    static func createPhotoDetailViewModel(photo: Photo) -> PhotoDetailViewModel {
        PhotoDetailViewModel(photo: Photo.mock1())
    }
    
    static func createFavouritesViewModel(persistenceStoreManager: PersistentStoreManageable = MockPersistentStoreManager.shared) -> FavouritesViewModel {
        FavouritesViewModel(persistenceStoreManager: MockPersistentStoreManager.shared)
    }
    
    static func createPhotoGalleryViewModel() -> PhotoGalleryViewModel {
        PhotoGalleryViewModel(repository: PhotoRepository(service: createPhotoService(), persistentStoreManager: createPersistentStoreManager(), networkMonitor: createNetworkMonitor()))
    }
    
    static func createLogger() -> Logger {
        Logger.shared
    }
    
    static func createMainView() -> PhotoGallery.MainView {
        MainView(galleryView: createGalleryView(), favouritesView: createFavouritesView())
    }
    
    static func createGalleryView() -> PhotoGallery.GalleryView<PhotoGallery.PhotoGalleryViewModel> {
        GalleryView(viewModel: PhotoGalleryViewModel(repository: PhotoRepository(service: createPhotoService(), networkMonitor: createNetworkMonitor())))
    }
    
    static func createFavouritesView() -> PhotoGallery.FavouritesView<PhotoGallery.FavouritesViewModel> {
        FavouritesView(viewModel: FavouritesViewModel(favouriteList: [Photo.mock1()]))
    }
    
    static func createPhotoView(urlString: String) -> PhotoGallery.PhotoView {
        PhotoView(urlString: urlString, uiImage: #imageLiteral(resourceName: "placeholder"))
    }
    
    static func createPhotoDetailView(photo: PhotoGallery.Photo = Photo.mock1()) -> PhotoGallery.PhotoDetailView<PhotoGallery.PhotoDetailViewModel> {
        PhotoDetailView(viewModel: PhotoDetailViewModel(photo: photo))
    }
    
    static func createPhotoRepository() -> PhotoRepositoryProtocol {
        return PhotoRepository(service: createPhotoService(), persistentStoreManager: createPersistentStoreManager(), networkMonitor: createNetworkMonitor())
    }

    static func createPhotoService() -> PhotoServiceProtocol {
        return PhotoService(networkManager: createNetworkManager())
    }

    static func createNetworkManager() -> NetworkManageable {
        return MockNetworkManager()
    }

    static func createNetworkManager(response: (Data?, Error?)) -> MockNetworkManager {
        let networkManager = MockNetworkManager()
        networkManager.mockData = response.0
        networkManager.mockError = response.1
        return networkManager
    }

    static func createPersistentStoreManager() -> PersistentStoreManageable {
        return MockPersistentStoreManager.shared
    }
}
