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
        let testString = "Test No Spaces"
        XCTAssertEqual(testString.formatAsURL(), "Test%20No%20Spaces")
    }
    
    func test_format_as_url_empty() {
        let emptyTestString = ""
        XCTAssertNil(emptyTestString.formatAsURL())
    }
    
    func test_date_formatter_convert_date_time_to_string() {
        let dateToFormat = "2022-01-28 13:12:11"
        let expectedDateString = "1:12 PM"
        let resultString = DateFormatter.convertDateTimeToString(dateString: dateToFormat)
        XCTAssertEqual(resultString, expectedDateString)
    }
    
    func test_date_formatter_convert_date_time_to_string_bad_input() {
        let dateToFormat = "Not a date"
        let resultString = DateFormatter.convertDateTimeToString(dateString: dateToFormat)
        XCTAssertEqual(resultString, nil)
    }
}
