//
//  Photo.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation

// MARK: - Photo: This is photo model based on json https://jsonplaceholder.typicode.com/photos

struct Photo: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String

    init(id: Int, albumId: Int, title: String, url: String, thumbnailUrl: String) {
        self.id = id
        self.albumId = albumId
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.albumId = try container.decode(Int.self, forKey: .albumId)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
    }
}
