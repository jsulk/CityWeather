//
//  ExtensionHelperTests.swift
//  CityWeatherTests
//
//  Created by Jake Sulkoske on 4/3/22.
//

@testable import CityWeather
import XCTest

class ExtensionHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_format_as_url() {
        let testString: String = "Test No Spaces"
        XCTAssertEqual(testString.formatAsURL(), "Test%20No%20Spaces")
    }
    
    func test_format_as_url_empty() {
        let emptyTestString: String = ""
        XCTAssertNil(emptyTestString.formatAsURL())
    }
}
