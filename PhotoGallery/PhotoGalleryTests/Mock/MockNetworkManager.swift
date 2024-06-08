//
//  MockNetworkManager.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation

class MockNetworkManager: NetworkManageable {

    enum MockError: Error {
        case customError
    }

    var mockData: Data?
    var mockError: Error?

    func fetchData(from url: URL) async throws -> Data {
        if let error = mockError {
            throw error
        }
        if let data = mockData {
            return data
        }
        throw MockError.customError
    }
}
