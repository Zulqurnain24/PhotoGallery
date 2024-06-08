//
//  MainView.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import SwiftUI

// MARK: - MainView: View representing the main view of the application.

struct MainView: View {
    let galleryView: GalleryView<PhotoGalleryViewModel>
    let favouritesView: FavouritesView<FavouritesViewModel>

    init(galleryView: GalleryView<PhotoGalleryViewModel>, favouritesView: FavouritesView<FavouritesViewModel>) {
        self.galleryView = galleryView
        self.favouritesView = favouritesView
    }

    var body: some View {
        TabView {
            galleryView.tabItem {
                Label(AppConfig.galleryTitle, systemImage: AppConfig.galleryTabImage)
            }
            favouritesView.tabItem {
                Label(AppConfig.favouritesTitle, systemImage: AppConfig.favouriteTabImage)
            }
        }
    }
}

#Preview {
    MockFactory.createMainView()
}
