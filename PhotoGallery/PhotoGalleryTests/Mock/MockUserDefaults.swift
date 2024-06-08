//
//  MockCoreDataStack.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import CoreData
import Foundation
@testable import PhotoGallery

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func data(forKey defaultName: String) -> Data?
}

class MockUserDefaults: UserDefaultsProtocol {
    private var storage: [String: Any] = [:]

    func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }

    func data(forKey defaultName: String) -> Data? {
        return storage[defaultName] as? Data
    }
}
