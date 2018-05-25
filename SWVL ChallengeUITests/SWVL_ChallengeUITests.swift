//
//  SWVL_ChallengeUITests.swift
//  SWVL ChallengeUITests
//
//  Created by Mohamed Saeed on 5/19/18.
//  Copyright © 2018 kalamoni. All rights reserved.
//

import XCTest

class SWVL_ChallengeUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMapViewComponents() {
        
        XCUIDevice.shared.orientation = .portrait
        
        let app = XCUIApplication()
        let mapView = app.otherElements["mapView"]
        XCTAssertTrue(mapView.exists, "MapView is not available")
        
        let locateMeButton = app.buttons["LocateMeButton"]
        XCTAssertTrue(locateMeButton.exists, "locateMe button is not available")
        
        
        let linesCollectionView = XCUIApplication().collectionViews["linesCollectionView"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: linesCollectionView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(linesCollectionView.exists, "Lines selector doesn't exist")
        XCTAssertTrue(linesCollectionView.cells.count > 0, "linesCollectionView failed to load")
        
        
        let stationImage = linesCollectionView.cells.firstMatch.images["BusLineImage"]
        XCTAssertTrue(stationImage.exists, "Lines' cell image doesn't exist")
        
        let stationFrom = linesCollectionView.cells.firstMatch.staticTexts["BusLineFrom"]
        XCTAssertTrue(stationFrom.exists, "Lines' From Station label doesn't exist")
        
        let stationTo = linesCollectionView.cells.firstMatch.staticTexts["BusLineTo"]
        XCTAssertTrue(stationTo.exists, "Lines' To Station label doesn't exist")
        
    }
    
}
