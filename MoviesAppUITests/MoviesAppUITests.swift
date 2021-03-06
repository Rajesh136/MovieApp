//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import XCTest

class MoviesAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 4).otherElements.children(matching: .image).element.tap()
        
        let moviesListButton = app.navigationBars["MoviesApp.MovieDetailsView"].buttons["Movies List"]
        moviesListButton.tap()
        
       collectionViewsQuery.element.swipeUp()
        let collectionView = app.otherElements.containing(.navigationBar, identifier:"Movies List").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element
        collectionView.swipeUp()
        collectionView.swipeUp()
        
        
    }
    
    func testMoviesCollectionViewController(){
        
        
        let app = XCUIApplication()
        app.otherElements.containing(.navigationBar, identifier:"Movies List").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeUp()
        
        let image = app.collectionViews.children(matching: .cell).element(boundBy: 13).otherElements.children(matching: .image).element
        image.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Show full"].tap()
        elementsQuery.buttons["Show less"].tap()
        app.navigationBars["MoviesApp.MovieDetailsView"].buttons["Movies List"].tap()
        image.swipeUp()
        
    }
    
}
