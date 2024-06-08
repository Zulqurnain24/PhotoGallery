//
//  GridCellView.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 19/05/2024.
//

import SwiftUI

// MARK: - GridCellView: View representing a grid cell displaying a photo.

struct GridCellView: View {
    let photo: Photo

    var body: some View {
        NavigationLink(destination: Factory.createPhotoDetailView(photo: photo)) {
            Factory.createPhotoView(urlString: photo.url)
        }
    }
}

#Preview {
    MockFactory.createGridCellView()
}
