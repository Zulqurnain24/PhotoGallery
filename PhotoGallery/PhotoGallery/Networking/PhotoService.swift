//
//  PhotoService.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation

protocol PhotoServiceProtocol {
    var networkManager: NetworkManageable { get set }
    func fetchPhotos(page: Int, limit: Int) async throws -> [Photo]
}

// MARK: - PhotoService: Class implementing the PhotoServiceProtocol for fetching photos from a remote server.

class PhotoService: PhotoServiceProtocol {
    var networkManager: NetworkManageable

    init(networkManager: NetworkManageable = Factory.createNetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchPhotos(page: Int, limit: Int) async throws -> [Photo] {
        guard let url = URL(string: "\(AppConfig.baseURL)?_page=\(page)&_limit=\(limit)") else {
            throw PhotoGalleryError.networkError("Invalid url")
        }
        let data = try await networkManager.fetchData(from: url)
        return try JSONDecoder().decode([Photo].self, from: data)
    }
}
