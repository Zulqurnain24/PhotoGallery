//
//  Logger.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import Foundation

// MARK: - Logger: It is used for logging

class Logger {
    static let shared = Logger()

    func log(_ message: String) {
        #if DEBUG
        print("📄 [LOG]: \(message)")
        #endif
    }

    func error(_ message: String) {
        #if DEBUG
        print("❌ [ERROR]: \(message)")
        #endif
    }
}
