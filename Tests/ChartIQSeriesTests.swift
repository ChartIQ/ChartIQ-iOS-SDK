//
//  ChartIQSeriesTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQSeriesTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Init with Parameters

  func testInitWithParameters() {
    // Given
    let symbolName = "AAPL"
    let color = UIColor.green

    // When
    let series = ChartIQSeries(symbolName: symbolName,
                               color: color)

    // Then
    XCTAssertEqual(symbolName, series.symbolName)
    XCTAssertEqual(color, series.color)
  }

  // MARK: - Tests Init with Dictionary and Key

  func testInitWithDictionaryAndKey() {
    // Given
    let dictionary: [String: Any] = [
      "AAPL": [
        "color": "#00ff00",
        "isComparison": true
      ]
    ]
    let key = "AAPL"
    let color = UIColor.green
    let symbolName = "AAPL"

    // When
    let series = ChartIQSeries(dictionary: dictionary, key: key)

    // Then
    XCTAssertNotNil(series)
    XCTAssertEqual(symbolName, series?.symbolName)
    XCTAssertEqual(color, series?.color)
  }

  func testInitWithIncorrectParametersAndKey() {
    // Given
    let dictionary: [String: Any] = [
      "NIKE": [
        "color": "#00ff00",
        "isComparison": true
      ]
    ]
    let key = "AAPL"

    // When
    let series = ChartIQSeries(dictionary: dictionary, key: key)

    // Then
    XCTAssertNil(series)
  }
}
