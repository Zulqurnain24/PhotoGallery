//
//  TestPersistentStore.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import XCTest
@testable import PhotoGallery

class PersistentStoreManagerTests: XCTestCase {
    override func tearDown() async throws {
        let key = "testKey"
        PersistentStoreManager.shared.clearData(key)
    }

    func testEncodeAndSave_Success() {
        // Given
        let manager = PersistentStoreManager.shared
        let key = "testKey"
        let value = TestObject(name: "Test")

        // When
        manager.encodeAndSave(key, value: value)

        // Then
        let retrievedValue: TestObject? = manager.getAndDecode(key, TestObject.self)
        XCTAssertNotNil(retrievedValue)
        XCTAssertEqual(retrievedValue?.name, "Test")
    }

    func testencodeAndSave() {
        // Given
        let manager = PersistentStoreManager.shared
        let key = "testKey"
        let value = TestObject(name: "Test")

        // When
        manager.encodeAndSave(key, value: value)

        // Then
        let retrievedValue: TestObject? = manager.getAndDecode(key, TestObject.self)
        XCTAssertNotNil(retrievedValue)
        XCTAssertEqual(retrievedValue?.name, "Test")
    }

    func testgetAndDecode_Success() {
        // Given
        let manager = PersistentStoreManager.shared
        let key = "testKey"
        let value = TestObject(name: "Test")
        manager.encodeAndSave(key, value: value)

        // When
        let retrievedValue: TestObject? = manager.getAndDecode(key, TestObject.self)

        // Then
        XCTAssertNotNil(retrievedValue)
        XCTAssertEqual(retrievedValue?.name, "Test")
    }

    func testgetAndDecode_Failure() {
        // Given
        let manager = PersistentStoreManager.shared
        let key = "testKey"

        // When
        let retrievedValue: TestObject? = manager.getAndDecode(key, TestObject.self)

        // Then
        XCTAssertNil(retrievedValue)
    }

    func testGetAndDecode_Success() {
        // Given
        let manager = PersistentStoreManager.shared
        let key = "testKey"
        let value = TestObject(name: "Test")
        manager.encodeAndSave(key, value: value)

        // When
        let retrievedValue: TestObject? = manager.getAndDecode(key, TestObject.self)

        // Then
        XCTAssertNotNil(retrievedValue)
        XCTAssertEqual(retrievedValue?.name, "Test")
    }

    func testClearData() {
        // Given
        let manager = PersistentStoreManager.shared
        let key = "testKey"
        let value = TestObject(name: "Test")
        manager.encodeAndSave(key, value: value)

        // When
        manager.clearData(key)

        // Then
        let retrievedValue: TestObject? = manager.getAndDecode(key, TestObject.self)
        XCTAssertNil(retrievedValue)
    }
}

// Mock object for testing Codable conformance
struct TestObject: Codable {
    let name: String
}

