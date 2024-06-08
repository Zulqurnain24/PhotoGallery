//
//  FavouritesView.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import SwiftUI

// MARK: - FavouritesView: View representing the favorites view.

struct FavouritesView<ViewModel: FavouritesViewModelable>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            createFavouritePhotosList()
        }
    }

    fileprivate func createFavouritePhotosList() -> some View {
        return List {
            ForEach(viewModel.favouriteList) { photo in
                NavigationLink(destination: Factory.createPhotoDetailView(photo: photo, isFavorite: true)) {
                    HStack {
                        Factory.createPhotoView(urlString: photo.thumbnailUrl)
                            .frame(width: AppConfig.thumbnailSize, height: AppConfig.thumbnailSize)
                            .clipShape(RoundedRectangle(cornerRadius: AppConfig.thumbnailCellCornerRadius))
                        Text(photo.title)
                            .lineLimit(1)
                        Spacer()
                        Button(action: {
                            viewModel.removeFromFavourites(photo)
                        }) {
                            Image(systemName: AppConfig.trashImage)
                        }
                        .accessibilityIdentifier("addToFavourites")
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
        }
        .onAppear {
            viewModel.populateFavouritesList()
        }
        .navigationTitle(AppConfig.favouritesTitle)
    }
}

#Preview {
    MockFactory.createFavouritesView()
}
