//
//  NetworkMonitorTests.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 09/06/2024.
//

import XCTest
import Combine
@testable import PhotoGallery

class NetworkMonitorTests: XCTestCase {
    var monitor: NetworkMonitorable!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        monitor.stopMonitoring()
        monitor = nil
        cancellables = nil
        super.tearDown()
    }

    func testNetworkMonitor_whenInitialized_isConnectedIsTrue() {
        let expectation = XCTestExpectation(description: "isConnected is true")

        let mockMonitor = MockNWPathMonitor(status: .satisfied)
        monitor = mockMonitor as? any NetworkMonitorable

        XCTAssertTrue((monitor as any NetworkMonitorable).isConnected)
    }

    func testNetworkMonitor_whenNetworkBecomesUnsatisfied_isConnectedIsFalse() {
        let expectation = XCTestExpectation(description: "isConnected is false")

        let mockMonitor = MockNWPathMonitor(status: .unsatisfied)
        monitor = mockMonitor as? any NetworkMonitorable

        XCTAssertFalse((monitor as any NetworkMonitorable).isConnected)
    }
}
