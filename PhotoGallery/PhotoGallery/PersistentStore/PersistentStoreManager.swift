//
//  PersistentStoreManager.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import Foundation

protocol PersistentStoreManageable {
    func encodeAndSave<T: Encodable>(_ key: String, value: T)
    func getAndDecode<T: Decodable>(_ key: String, _ type: T.Type) -> T?
    func clearData(_ key: String)
}

// MARK: - PersistentStoreManager: It manages the persistence related logic

class PersistentStoreManager: PersistentStoreManageable {

    enum PersistentStore: Error {
        case decodingError
    }

    let encoder: JSONEncoder

    init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }

    static let shared = PersistentStoreManager()

    func encodeAndSave<T: Encodable>(_ key: String, value: T) {
        guard let encoded = try? encoder.encode(value) else {
            Factory.createLogger().error("\(AppConfig.unableToEncodeValue) \(value)")
            return
        }
        UserDefaults.standard.set(encoded, forKey: key)

        Factory.createLogger().log(AppConfig.printPersistentEncodableObject(key: key, value: "\(value.self)"))
    }

    func getAndDecode<T: Decodable>(_ key: String, _ type: T.Type) -> T? {
        let updatedkey = key
        let decoder = JSONDecoder()
        var value: T?
        if let data = UserDefaults.standard.data(forKey: updatedkey) {
            guard let decodedValue = try? decoder.decode(type, from: data) else {
                Factory.createLogger().log(AppConfig.printPersistentDecodableObject(key: key, value: "\(value.self)"))
                return nil
            }
            value = decodedValue
        }

        Factory.createLogger().log(AppConfig.printPersistentDecodableObject(key: key, value: "\(value.self)"))

        return value
    }

    func clearData(_ key: String) {
        let updatedkey = key
        UserDefaults.standard.removeObject(forKey: updatedkey)

        Factory.createLogger().log("\(AppConfig.clearDataForKey) \(key)")
    }
}
