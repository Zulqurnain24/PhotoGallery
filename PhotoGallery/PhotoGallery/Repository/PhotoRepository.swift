//
//  PhotoRepository.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation

protocol PhotoRepositoryProtocol {
    func getPhotos(page: Int, limit: Int) async throws -> [Photo]
    func savePhotosToCache(_ photos: [Photo], forKey key: String) async
    func prefetchPhotos(startingFrom page: Int, limit: Int) async throws
}

// MARK: - PhotoRepository: Class implementing the PhotoRepositoryProtocol for managing photo data.

class PhotoRepository: PhotoRepositoryProtocol {
    private let service: PhotoServiceProtocol
    let persistentStoreManager: PersistentStoreManageable
    let networkMonitor: NetworkMonitorable
    private let logger = Factory.createLogger()

    init(service: PhotoServiceProtocol, 
         persistentStoreManager: PersistentStoreManageable = PersistentStoreManager(),
         networkMonitor: NetworkMonitorable) {
        self.service = service
        self.persistentStoreManager = persistentStoreManager
        self.networkMonitor = networkMonitor

        self.networkMonitor.startMonitoring()
    }

    func getPhotos(page: Int, limit: Int) async throws -> [Photo] {
        logger.log("\(AppConfig.fetchingImagesForPage) \(page) \(AppConfig.withLimit) \(limit)")

        let cacheKey = "\(page)_\(limit)"
        if let photos = persistentStoreManager.getAndDecode(cacheKey, [Photo].self) {
            return photos
        }

        guard networkMonitor.isConnected else {
            logger.error(AppConfig.notConnectedToInternet)
            return []
        }

        let photos = try await service.fetchPhotos(page: page, limit: limit)
        savePhotosToCache(photos, forKey: cacheKey)
        return photos
    }

    func savePhotosToCache(_ photos: [Photo], forKey key: String) {
        persistentStoreManager.encodeAndSave(key, value: photos)
    }

    func prefetchPhotos(startingFrom page: Int, limit: Int) async throws {
        let cacheKey = "\(page)_\(limit)"
        let results = await withTaskGroup(of: [Photo].self) { group in
            for pageOffset in 0..<AppConfig.prefetchPages {
                group.addTask { [service] in
                    do {
                        return try await service.fetchPhotos(page: page + pageOffset, limit: limit)
                    } catch {
                        self.logger.error("Error fetching photos: \(error)")
                        return []
                    }
                }
            }
            var allPhotos: [Photo] = []
            for await photos in group {
                allPhotos.append(contentsOf: photos)
            }
            return allPhotos
        }
        
        guard networkMonitor.isConnected else {
            logger.error(AppConfig.notConnectedToInternet)
            return
        }

        savePhotosToCache(results, forKey: cacheKey)
    }

    deinit {
        networkMonitor.stopMonitoring()
    }
}
