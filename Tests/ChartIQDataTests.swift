//
//  ChartIQDataTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQDataTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Init with Parameters

  func testInitWithParameters() {
    // Given
    let date = Date()
    let open: Double = 100.59
    let high: Double = 100.87
    let low: Double = 99.909
    let close: Double = 100
    let volume: Double = 65.0
    let adjClose: Double = 100

    // When
    let chartIQData = ChartIQData(date: date,
                                  open: open,
                                  high: high,
                                  low: low,
                                  close: close,
                                  volume: volume,
                                  adjClose: adjClose)

    // Then
    XCTAssertEqual(date, chartIQData.date)
    XCTAssertEqual(open, chartIQData.open)
    XCTAssertEqual(high, chartIQData.high)
    XCTAssertEqual(low, chartIQData.low)
    XCTAssertEqual(close, chartIQData.close)
    XCTAssertEqual(volume, chartIQData.volume)
    XCTAssertEqual(adjClose, chartIQData.adjClose)
  }

  func testInitWithDictionary() {
    // Given
    let open: Double = 100.59
    let high: Double = 100.87
    let low: Double = 99.909
    let close: Double = 100
    let volume: Double = 0.0
    let adjClose: Double = 100

    let dictionary: [String: Any] = [
      "Close": close,
      "High": high,
      "Low": low,
      "Open": open,
      "Volume": volume
    ]

    // When
    let chartIQData = ChartIQData(dictionary: dictionary)

    // Then
    XCTAssertEqual(open, chartIQData.open)
    XCTAssertEqual(high, chartIQData.high)
    XCTAssertEqual(low, chartIQData.low)
    XCTAssertEqual(close, chartIQData.close)
    XCTAssertEqual(volume, chartIQData.volume)
    XCTAssertEqual(adjClose, chartIQData.adjClose)
    XCTAssertEqual(chartIQData.close, chartIQData.adjClose)
  }

  func testInitWithEmptyDictionary() {
    // Given
    let open: Double = 0.0
    let high: Double = 0.0
    let low: Double = 0.0
    let close: Double = 0.0
    let volume: Double = 0.0
    let adjClose: Double = 0.0

    let dictionary: [String: Any] = [:]

    // When
    let chartIQData = ChartIQData(dictionary: dictionary)

    // Then
    XCTAssertEqual(open, chartIQData.open)
    XCTAssertEqual(high, chartIQData.high)
    XCTAssertEqual(low, chartIQData.low)
    XCTAssertEqual(close, chartIQData.close)
    XCTAssertEqual(volume, chartIQData.volume)
    XCTAssertEqual(adjClose, chartIQData.adjClose)
    XCTAssertEqual(chartIQData.close, chartIQData.adjClose)
  }

  // MARK: - Tests Convert to Dictionary

  func testToDictionaryMethod() {
    // Given
    let date = Date()
    let open: Double = 100.59
    let high: Double = 100.87
    let low: Double = 99.909
    let close: Double = 100
    let volume: Double = 65_253
    let adjClose: Double = 100
    let chartIQData = ChartIQData(date: date,
                                  open: open,
                                  high: high,
                                  low: low,
                                  close: close,
                                  volume: volume,
                                  adjClose: adjClose)
    // When
    let chartIQDataDict = chartIQData.toDictionary()

    // Then
    let dateString = ChartIQUtils.chartDateFormatter.string(from: date)
    XCTAssertEqual(dateString, chartIQDataDict[Const.Data.dateParam] as? String)
    XCTAssertEqual(open, chartIQDataDict[Const.Data.openParam] as? Double)
    XCTAssertEqual(high, chartIQDataDict[Const.Data.highParam] as? Double)
    XCTAssertEqual(low, chartIQDataDict[Const.Data.lowParam] as? Double)
    XCTAssertEqual(close, chartIQDataDict[Const.Data.closeParam] as? Double)
    XCTAssertEqual(volume, chartIQDataDict[Const.Data.volumeParam] as? Double)
    XCTAssertEqual(adjClose, chartIQDataDict[Const.Data.adjCloseParam] as? Double)
  }

  // MARK: - Tests Convert to JSON

  func testToJSONStringMethod() {
    // Given
    let date = Date()
    let open: Double = 100.59
    let high: Double = 100.87
    let low: Double = 99.909
    let close: Double = 100.0
    let volume: Double = 65_253.0
    let adjClose: Double = 100.0
    let chartIQData = ChartIQData(date: date,
                                  open: open,
                                  high: high,
                                  low: low,
                                  close: close,
                                  volume: volume,
                                  adjClose: adjClose)
    // When
    let chartIQJSONString = chartIQData.toJSONString()

    // Then
    // Keys Exists
    XCTAssertTrue(chartIQJSONString.contains(Const.Data.dateParam))
    XCTAssertTrue(chartIQJSONString.contains(Const.Data.openParam))
    XCTAssertTrue(chartIQJSONString.contains(Const.Data.highParam))
    XCTAssertTrue(chartIQJSONString.contains(Const.Data.lowParam))
    XCTAssertTrue(chartIQJSONString.contains(Const.Data.closeParam))
    XCTAssertTrue(chartIQJSONString.contains(Const.Data.volumeParam))
    XCTAssertTrue(chartIQJSONString.contains(Const.Data.adjCloseParam))

    // Values Exists
    let dateString = ChartIQUtils.chartDateFormatter.string(from: date)
    XCTAssertTrue(chartIQJSONString.contains(dateString))
    XCTAssertTrue(chartIQJSONString.contains(open.stringValue))
    XCTAssertTrue(chartIQJSONString.contains(high.stringValue))
    XCTAssertTrue(chartIQJSONString.contains(low.stringValue))
    XCTAssertTrue(chartIQJSONString.contains(close.stringValue))
    XCTAssertTrue(chartIQJSONString.contains(volume.stringValue))
    XCTAssertTrue(chartIQJSONString.contains(adjClose.stringValue))
  }
}

// MARK: - Double extension

extension Double {
  var stringValue: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}
