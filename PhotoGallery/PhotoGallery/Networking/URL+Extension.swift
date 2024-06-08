//
//  URL+Extension.swift
//  PhotoGallery
//
//  Created by Mohammad Zulqurnain on 19/05/2024.
//

import UIKit

// MARK: - URL+Extension: For assessing the validity of urls

extension URL {
    func isValid() -> Bool {
        if let url = NSURL(string: absoluteString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}
