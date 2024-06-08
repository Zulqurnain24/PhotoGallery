//
//  MockPersistentStoreManager.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import Foundation
@testable import PhotoGallery

class MockPersistentStoreManager: PersistentStoreManageable {
    func getAndDecode<T>(_ key: String, _ type: T.Type) -> T? where T : Decodable {
        guard let data = store[key] as? Data else { return nil }
        let decoder = JSONDecoder()
        guard let decodedValue = try? decoder.decode(type, from: data) else {
            MockFactory.createLogger().error("Unable to decode the value for key \(key)")
            return nil
        }
        return decodedValue
    }
    
    static let shared = MockPersistentStoreManager()
    var store: [String: Any] = [:]

    func encodeAndSave<T>(_ key: String, value: T) where T : Encodable {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(value) else {
            MockFactory.createLogger().error("Error: Unable to encode the value \(value)")
            return
        }
        store[key] = encoded
    }

    func clearData(_ key: String) {
        store.removeValue(forKey: key)
    }
}
