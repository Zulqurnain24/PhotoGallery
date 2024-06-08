//
//  AppFactory.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation
import CoreData

import Foundation
import CoreData
import SwiftUI
import Network

// MARK: - FactoryProtocol: Protocol defining a factory for creating various components used in the application.

protocol FactoryProtocol {
    static func createGridCellView(photo: Photo) -> GridCellView
    static func createPhotoService() -> PhotoServiceProtocol
    static func createPhotoRepository() -> PhotoRepositoryProtocol
    static func createNetworkManager() -> NetworkManageable
    static func createPersistentStoreManager() -> PersistentStoreManageable
    static func createMainView() -> MainView
    static func createGalleryView() -> GalleryView<PhotoGalleryViewModel>
    static func createFavouritesView() -> FavouritesView<FavouritesViewModel>
    static func createPhotoView(urlString: String) -> PhotoView
    static func createPhotoDetailView(photo: Photo, isFavorite: Bool) -> PhotoDetailView<PhotoDetailViewModel>
    static func createLogger() -> Logger
    static func createPhotoDetailViewModel(photo: Photo) -> PhotoDetailViewModel
    static func createFavouritesViewModel(persistenceStoreManager: PersistentStoreManageable) -> FavouritesViewModel
    static func createPhotoGalleryViewModel() -> PhotoGalleryViewModel
    static func createNetworkMonitor(status: NWPath.Status) -> NetworkMonitorable
}

extension FactoryProtocol {
    static func createNetworkMonitor(status: NWPath.Status = .requiresConnection) -> NetworkMonitorable {
        createNetworkMonitor(status: status)
    }
}

class Factory: FactoryProtocol {
    static func createNetworkMonitor() -> NetworkMonitor {
        NetworkMonitor(monitor: NWPathMonitor())
    }
    
    static func createGridCellView(photo: Photo) -> GridCellView {
        GridCellView(photo: photo)
    }

    static func createPhotoDetailViewModel(photo: Photo = Photo.mock1()) -> PhotoDetailViewModel {
        PhotoDetailViewModel(photo: photo, persistenceStoreManager: PersistentStoreManager.shared)
    }
    
    static func createFavouritesViewModel(persistenceStoreManager: PersistentStoreManageable) -> FavouritesViewModel {
        FavouritesViewModel()
    }
    
    static func createPhotoGalleryViewModel() -> PhotoGalleryViewModel {
        PhotoGalleryViewModel(repository: PhotoRepository(service: PhotoService(),
                                                          networkMonitor: createNetworkMonitor()))
    }
    
    static func createLogger() -> Logger {
        Logger.shared
    }
    
    static func createGalleryView() -> GalleryView<PhotoGalleryViewModel> {
        GalleryView(viewModel: createPhotoGalleryViewModel())
    }

    static func createFavouritesView() -> FavouritesView<FavouritesViewModel> {
        FavouritesView(viewModel: createFavouritesViewModel(persistenceStoreManager: PersistentStoreManager.shared))
    }

    static func createPhotoView(urlString: String) -> PhotoView {
        PhotoView(urlString: urlString)
    }

    static func createPhotoDetailView(photo: Photo, isFavorite: Bool = false) -> PhotoDetailView<PhotoDetailViewModel> {
        PhotoDetailView(viewModel: createPhotoDetailViewModel(photo: photo), isFavorite: isFavorite)
    }

    static func createMainView() -> MainView {
        MainView(galleryView: Factory.createGalleryView(), favouritesView: Factory.createFavouritesView())
    }

    static func createPhotoService() -> PhotoServiceProtocol {
        return PhotoService(networkManager: createNetworkManager())
    }

    static func createPhotoRepository() -> PhotoRepositoryProtocol {
        return PhotoRepository(service: Factory.createPhotoService(), persistentStoreManager: Factory.createPersistentStoreManager(), networkMonitor: createNetworkMonitor())
    }

    static func createNetworkManager() -> NetworkManageable {
        return NetworkManager.shared
    }

    static func createPersistentStoreManager() -> PersistentStoreManageable {
        return PersistentStoreManager.shared
    }
}
