//
//  NetworkMonitor.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 09/06/2024.
//

import Network
import Combine

protocol NetworkMonitorable: AnyObject {
    var isConnected: Bool { get }
    var isConnectedValue: Bool { get }
    func startMonitoring()
    func stopMonitoring()
}

class NetworkMonitor: ObservableObject, NetworkMonitorable {
    
    @Published private(set) var isConnected: Bool = true
    private var monitor: NWPathMonitor?
    private var queue = DispatchQueue.global()

    init(monitor: NWPathMonitor? = nil) {
        self.monitor = monitor ?? NWPathMonitor()
    }

    var isConnectedValue: Bool {
        return isConnected
    }

    var isConnectedPublisher: Published<Bool>.Publisher {
        return $isConnected
    }

    func startMonitoring() {
        monitor?.pathUpdateHandler = { [weak self] path in
            self?.queue.sync {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor?.start(queue: queue)
    }

    func stopMonitoring() {
        monitor?.cancel()
    }

    deinit {
        monitor?.cancel()
    }
}
