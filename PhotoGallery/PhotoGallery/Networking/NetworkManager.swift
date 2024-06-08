//
//  Networking.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation

protocol NetworkManageable {
    func fetchData(from url: URL) async throws -> Data
}

// MARK: - NetworkManager: Class implementing core networking related logic

class NetworkManager: NetworkManageable {
    static let shared = NetworkManager()
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchData(from url: URL) async throws -> Data {
        do {
            guard url.isValid() else {
                throw PhotoGalleryError.networkError("Invalid URL")
            }
            let (data, urlResponse) = try await urlSession.data(from: url)
            guard let httpResponse = urlResponse as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw PhotoGalleryError.networkError("HTTP status code: \((urlResponse as? HTTPURLResponse)?.statusCode ?? -1)")
            }
            Factory.createLogger().log("For url: \(url), Data received \(data)")
            return data
        } catch {
            Factory.createLogger().error("Networking error: \(error)")
            throw PhotoGalleryError.networkError("Networking error: \(error)")
        }
    }
}
