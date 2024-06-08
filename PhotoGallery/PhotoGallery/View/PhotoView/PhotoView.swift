//
//  PhotoView.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import SwiftUI

// MARK: - PhotoView: View representing a photo fetched from a URL.

struct PhotoView: View {
    let urlString: String

    @State var uiImage: UIImage? = nil

    var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    func loadImage() {
        guard let url = URL(string: urlString) else {
            Factory.createLogger().error("\(AppConfig.imageLoadError) \(urlString)")
            return
        }

        if let cachedImage = ImageCacheManager.shared.image(for: url) {
            self.uiImage = cachedImage
        } else {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.uiImage = image
                            ImageCacheManager.shared.save(image, for: url)
                        }
                    }
                } catch {
                    Factory.createLogger().error("\(AppConfig.imageLoadError) \(error)")
                }
            }
        }
    }
}

#Preview {
    MockFactory.createPhotoView(urlString: "")
}
