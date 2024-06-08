//
//  AppConfig.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import Foundation

// MARK: - AppConfig: Struct defining various configurations for the application.

struct AppConfig {
    static let baseURL: String = "https://jsonplaceholder.typicode.com/photos"
    static let prefetchPages = 10
    static let pageLimit = 5
    static let imageLoadError = "Unable to load image from"
    static let removeButtonStatus =  "Remove from Favorites"
    static let addtoFavouriteButtonStatus =  "Add to Favorites"
    static let favouriteList = "favouriteList"
    static let photoDetail = "Photo Detail"
    static let galleryTitle = "Gallery"
    static let favouritesTitle = "Favourites"
    static let galleryTabImage = "photo.on.rectangle"
    static let favouriteTabImage = "heart.fill"
    static let trashImage = "trash"
    static let gridCellSize = CGFloat(100)
    static let gridCellImageSize = CGFloat(120)
    static let gridCellSpacing = CGFloat(5.0)
    static let scrollViewPadding = CGFloat(5.0)
    static let thumbnailSize = CGFloat(50.0)
    static let thumbnailCellCornerRadius = CGFloat(5.0)
    static let errorFetchingPhotos = "Error fetching photos:"
    static let errorPreFetchingPhotos = "Error fetching photos:"
    static let unableToEncodeValue = "Error: Unable to encode the value"
    static let clearDataForKey = "clear data for key"
    static func printPersistentEncodableObject(key: String, value: String) -> String {
        "encodeAndSave<T: Encodable>(_ key: \(key), value: \(value)"
    }
    static func printPersistentDecodableObject(key: String, value: String) -> String {
        "Unable to decode the value - getAndDecode<T: Decodable>(_ key: \(key), _ type: \(value)"
    }
    static let notConnectedToInternet = "Not connected to network"
    static let failedToDecodeCacheImages = "Failed to decode cached photos:"
    static let fetchingImagesForPage = "Fetching photos for page"
    static let withLimit = "with limit"
}
