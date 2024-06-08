//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation
import Combine

protocol PhotoGalleryViewModelable: ObservableObject {
    var photosList: [Photo] { set get }
    var isLoading: Bool { set get }
    var page: Int { get }
    var repository: PhotoRepositoryProtocol { get }
    var logger: Logger { get }
    func fetchPhotos()
}

// MARK: - PhotoGalleryViewModel: Protocol defining the requirements for a photo gallery view model.

class PhotoGalleryViewModel: PhotoGalleryViewModelable {
    @Published var photosList = [Photo]()
    @Published var isLoading = false
    var page = 1
    let repository: PhotoRepositoryProtocol
    let logger = Factory.createLogger()

    init(repository: PhotoRepositoryProtocol) {
        self.repository = repository
    }

    fileprivate func fetchPhotosForCurrentPage(_ page: Int) -> Task<(), Never> {
        return Task {
            do {
                async let fetchedPhotos = repository.getPhotos(page: page, limit: AppConfig.pageLimit)
                async let prefetchingPhotos: () = repository.prefetchPhotos(startingFrom: page + 1, limit: AppConfig.pageLimit)

                let newPhotos = try await fetchedPhotos
                _ = try await prefetchingPhotos

                await MainActor.run {
                    self.photosList.append(contentsOf: newPhotos)
                    self.page += 1
                    self.isLoading = false
                }
            } catch {
                self.logger.error("\(AppConfig.errorFetchingPhotos) \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }

    func fetchPhotos() {
        guard !isLoading else { return }
        isLoading = true

        _ = fetchPhotosForCurrentPage(page)
    }
}

