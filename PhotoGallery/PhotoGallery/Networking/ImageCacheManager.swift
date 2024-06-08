//
//  ImageCacheManager.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import UIKit

protocol ImageCacheManageable {
    func image(for url: URL) -> UIImage?

    func save(_ image: UIImage, for url: URL)
}

// MARK: - ImageCacheManager: This class deals with image caching.

class ImageCacheManager: ImageCacheManageable {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSURL, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    func image(for url: URL) -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        } else if let diskImage = loadImageFromDisk(for: url) {
            cache.setObject(diskImage, forKey: url as NSURL)
            return diskImage
        }
        return nil
    }

    func save(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
        saveImageToDisk(image, for: url)
    }

    private func loadImageFromDisk(for url: URL) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }

    private func saveImageToDisk(_ image: UIImage, for url: URL) {
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        if let imageData = image.pngData() {
            try? imageData.write(to: fileURL)
        }
    }
}
