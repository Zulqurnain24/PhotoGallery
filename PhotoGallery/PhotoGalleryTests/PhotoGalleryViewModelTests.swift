import XCTest
@testable import PhotoGallery

class PhotoGalleryViewModelTests: XCTestCase {

    func testFetchPhotos_Success() async {
        // Given
        let mockRepository = MockPhotoRepository()
        let expectedPhotos = [Photo.mock1(), Photo.mock2()]
        mockRepository.stubbedGetPhotosResult = .success(expectedPhotos)

        let expectation = XCTestExpectation(description: "GetPhotos completes successfully")

        Task {
            do {
                // When
                let photos = try await mockRepository.getPhotos(page: 1, limit: 2)
                // Then
                XCTAssertEqual(photos, expectedPhotos)
                expectation.fulfill()
            } catch {
                XCTFail("Expected success, but got error: \(error)")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPhotos_Failure() async {
        // Given
        let mockRepository = MockPhotoRepository()

        // When
        mockRepository.stubbedGetPhotosResult = .failure(PhotoGalleryError.networkError("Mock error"))

        let expectation = XCTestExpectation(description: "GetPhotos completes successfully")

        Task {
            do {
                let photos = try await mockRepository.getPhotos(page: 1, limit: 2)
                XCTFail("Expected failure, but got success")
            } catch {
                // Then
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (PhotoGallery.PhotoGalleryError error 0.)")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

class MockPhotoRepository: PhotoRepositoryProtocol {
    var stubbedGetPhotosResult: Result<[Photo], Error>?
    var prefetchPhotosCallCount = 0

    func getPhotos(page: Int, limit: Int) async throws -> [Photo] {
        if let result = stubbedGetPhotosResult {
            switch result {
            case .success(let photos):
                return photos
            case .failure(let error):
                throw error
            }
        } else {
            return []
        }
    }

    func prefetchPhotos(startingFrom page: Int, limit: Int) async throws {
        prefetchPhotosCallCount += 1
    }

    func savePhotosToCache(_ photos: [PhotoGallery.Photo], forKey key: String) async {}
}
