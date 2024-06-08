//
//  Photo+Extension.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import Foundation

// MARK: - Photo+Extension: Extension on the Photo struct to provide mock data for testing purposes.

extension Photo {
    static func mock1() -> Self {
        Photo(id: 1, albumId: 1, title: "Mocked Title 1", url: "Mocked URL 1", thumbnailUrl: "Mocked Thumbnail URL 1")
    }
    static func mock2() -> Self {
        Photo(id: 2, albumId: 2, title: "Mocked Title 2", url: "Mocked URL 2", thumbnailUrl: "Mocked Thumbnail URL 2")
    }
}
