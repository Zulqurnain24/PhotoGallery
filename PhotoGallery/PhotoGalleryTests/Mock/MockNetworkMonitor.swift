//
//  MockNetworkMonitor.swift
//  PhotoGalleryTests
//
//  Created by Mohammad Zulqurnain on 09/06/2024.
//

import Combine
import Network

class MockNWPathMonitor: NetworkMonitorable {
    @Published private(set) var isConnected: Bool = true

    private var status: NWPath.Status

    init(status: NWPath.Status) {
        self.status = status
        self.isConnected = status == .satisfied
    }

    var isConnectedValue: Bool {
        return isConnected
    }

    func startMonitoring() {
        // Simulate path update
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isConnected = self.status == .satisfied
        }
    }

    func stopMonitoring() {
        // Do nothing
    }

    func updateStatus(to status: NWPath.Status) {
        self.status = status
        self.isConnected = status == .satisfied
    }
}
