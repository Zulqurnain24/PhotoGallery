//
//  ErrorHandling.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

// MARK: - PhotoGalleryError: Enum representing errors specific to the photo gallery functionality.

enum PhotoGalleryError: Error, Equatable {
    case networkError(String)
    case coreDataError(String)
}
