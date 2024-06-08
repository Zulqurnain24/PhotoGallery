//
//  DetailViewModel.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import Foundation
import SwiftUI

protocol PhotoDetailViewModelable: ObservableObject {
    var photo: Photo { get }
    var persistenceStoreManager: PersistentStoreManageable { get }

    func addToFavourites(_ photo: Photo)
    func removeFromFavourites(_ photo: Photo)
    func isImageFavourite() -> Bool
}

// MARK: - PhotoDetailViewModel: View model for managing photo detail view functionality.

class PhotoDetailViewModel: PhotoDetailViewModelable {
    
    let photo: Photo
    let persistenceStoreManager: PersistentStoreManageable

    init(photo: Photo,
         persistenceStoreManager: PersistentStoreManageable = PersistentStoreManager.shared) {
        self.photo = photo
        self.persistenceStoreManager = persistenceStoreManager
    }

    func addToFavourites(_ photo: Photo) {
        var favouriteList = persistenceStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self) ?? []
        guard !favouriteList.contains(photo) else { return }
        favouriteList.append(photo)
        persistenceStoreManager.encodeAndSave(AppConfig.favouriteList, value: favouriteList)
    }

    func removeFromFavourites(_ photo: Photo) {
        var favouriteList = persistenceStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self) ?? []
        for (index, element) in favouriteList.enumerated() where element.id == photo.id {
            favouriteList.remove(at: index)
        }
        persistenceStoreManager.encodeAndSave(AppConfig.favouriteList, value: favouriteList)
    }

    func isImageFavourite() -> Bool {
        let favouriteList = persistenceStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self)
        return favouriteList?.contains(photo) ?? false
    }
}
