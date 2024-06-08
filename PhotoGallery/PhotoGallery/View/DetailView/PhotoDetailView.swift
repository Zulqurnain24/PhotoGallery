//
//  DetailView.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 18/05/2024.
//

import Combine
import SwiftUI

// MARK: - PhotoDetailView: View representing the detailed view of a photo.

struct PhotoDetailView<ViewModel: PhotoDetailViewModelable>: View {
    var viewModel: ViewModel
    @State var isFavorite: Bool = false

    var body: some View {
        VStack(alignment: .center) {
            PhotoView(urlString: viewModel.photo.url)
            Button(action: {
                if isFavorite {
                    removeFavorite(viewModel.photo)
                } else {
                    addFavorite(viewModel.photo)
                }
                isFavorite.toggle()
            }) {
                Text(isFavorite ? AppConfig.removeButtonStatus : AppConfig.addtoFavouriteButtonStatus)
                    .padding()
                    .background(isFavorite ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .onAppear {
            let favouriteList = viewModel.persistenceStoreManager.getAndDecode(AppConfig.favouriteList, [Photo].self)
            isFavorite = favouriteList?.contains(viewModel.photo) ?? false
        }
        .navigationTitle(AppConfig.photoDetail)
    }

    func addFavorite(_ photo: Photo) {
        viewModel.addToFavourites(photo)
    }

    func removeFavorite(_ photo: Photo) {
        viewModel.removeFromFavourites(photo)
    }
}

#Preview {
    MockFactory.createPhotoDetailView()
}
