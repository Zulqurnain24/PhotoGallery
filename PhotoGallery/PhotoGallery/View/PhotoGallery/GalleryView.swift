//
//  GalleryView.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import SwiftUI

// MARK: - MainView: View representing the gallery of photos.

struct GalleryView<ViewModel: PhotoGalleryViewModelable>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            createAdaptiveGrid(viewModel: viewModel)
        }
    }

    fileprivate func createAdaptiveGrid(viewModel: ViewModel) -> some View {
        return ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: AppConfig.gridCellSize))], spacing: AppConfig.gridCellSpacing) {
                ForEach(viewModel.photosList) { photo in
                    Factory.createGridCellView(photo: photo)
                        .frame(width: AppConfig.gridCellImageSize, height: AppConfig.gridCellImageSize)
                        .clipped()
                        .onAppear {
                            if photo == viewModel.photosList.last {
                                viewModel.fetchPhotos()
                            }
                        }
                }
            }
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
        }
        .padding(.horizontal, AppConfig.scrollViewPadding)
        .navigationTitle(AppConfig.galleryTitle)
        .refreshable {
            Task { @MainActor in
                viewModel.fetchPhotos()
            }
        }
        .task { @MainActor in
            viewModel.fetchPhotos()

        }
    }
}

#Preview {
    MockFactory.createGalleryView()
}
