//
//  PhotoGalleryApp.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import SwiftUI

@main

// MARK: - PhotoGalleryApp: Main struct representing the Photo Gallery application

struct PhotoGalleryApp: App {
    var body: some Scene {
        WindowGroup {
            Factory.createMainView()
        }
    }
}
