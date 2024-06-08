//
//  FavouritesViewModel.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation
import Combine

protocol FavouritesViewModelable: ObservableObject {
    var favouriteList: [Photo] { get set }
    var persistentStoreManager: PersistentStoreManageable { get }
    func populateFavouritesList()
    func removeFromFavourites(_ photo: Photo)
}

// MARK: - FavouritesViewModel: View model for managing favorite photos.

class FavouritesViewModel: FavouritesViewModelable {
    
    @Published var favouriteList: [Photo]
    let persistentStoreManager: PersistentStoreManageable

    init(favouriteList: [Photo] = [],
         persistenceStoreManager: PersistentStoreManageable = PersistentStoreManager.shared) {
        self.favouriteList = favouriteList
        self.persistentStoreManager = persistenceStoreManager
    }

    func removeFromFavourites(_ photo: Photo) {
        favouriteList = persistentStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self) ?? []
        for (index, element) in favouriteList.enumerated() where element.id == photo.id {
            favouriteList.remove(at: index)
        }
        persistentStoreManager.encodeAndSave(AppConfig.favouriteList, value: favouriteList)
    }

    func populateFavouritesList() {
        favouriteList = persistentStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self) ?? []
    }
}
