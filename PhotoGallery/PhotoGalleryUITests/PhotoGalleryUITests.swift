//
//  PhotoGalleryUITests.swift
//  PhotoGalleryUITests
//
//  Created by Mohammad Zulqurnain on 17/05/2024.
//

import XCTest

class PhotoGalleryUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testTappingOnAGridItem() {
        let app = XCUIApplication()
        let element = app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element.children(matching: .button).element(boundBy: 6).tap()
    }

    func testTappingOnGridItemAndBackNavigate() {
        let app = XCUIApplication()
        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        app.navigationBars["Photo Detail"].buttons["Gallery"].tap()
    }

    func testFavouriteAndUnfavouriteAnItem() {
        let app = XCUIApplication()
        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        app.buttons.element(at: 1).tap()
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Favourites"].tap()
        app.collectionViews.firstMatch.tap()
        app.buttons.element(at: 1).tap()
    }
}

