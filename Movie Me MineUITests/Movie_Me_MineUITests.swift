//
//  Movie_Me_MineUITests.swift
//  Movie Me MineUITests
//
//  Created by SFurlani on 8/27/15.
//  Copyright © 2015 Optoro. All rights reserved.
//

import XCTest

class Movie_Me_MineUITests: XCTestCase {
        
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
    
    func testDetailAppearance() {
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.staticTexts["Minions"].tap()
        
        let detailView = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        
        expectationForPredicate(
            NSPredicate(format: "count == 1"),
            evaluatedWithObject: detailView.textViews,
            handler: nil)
        
        expectationForPredicate(
            NSPredicate(format: "count == 2"),
            evaluatedWithObject: detailView.images,
            handler: nil)
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
        
    }
    
    func testSearch() {
        let app = XCUIApplication()
        
        app.searchFields.element.tap()
        app.typeText("bob")
        app.typeText("\r")
        
        let searchResult = app.collectionViews.cells.otherElements.staticTexts["What About Bob?"]
        
        expectationForPredicate(
            NSPredicate(format: "exists == 1"),
            evaluatedWithObject: searchResult,
            handler: nil)
        
        waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    
}
