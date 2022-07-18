//
//  TestingTestingUITests.swift
//  TestingTestingUITests
//
//  Created by paige shin on 2022/07/17.
//

import XCTest

class TestingTestingUITests: XCTestCase {

    
    let hahaYouClickedStaticText = XCUIApplication().staticTexts["Haha you clicked"]
    hahaYouClickedStaticText.tap()
    hahaYouClickedStaticText.tap()
    func test_clickTextView_changeText() {
        
    }
    
}
