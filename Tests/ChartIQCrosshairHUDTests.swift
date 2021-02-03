//
//  ChartIQCrosshairHUDTests.swift
//  ChartIQTests
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQCrosshairHUDTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Init with Parameters

  func testInitWithParameters() {
    // Given
    let price: String = ""
    let volume: String = ""
    let open: String = ""
    let high: String = ""
    let close: String = ""
    let low: String = ""

    // When
    let crosshairHUD = ChartIQCrosshairHUD(price: price, volume: volume, open: open, high: high, close: close, low: low)

    // Then
    XCTAssertEqual(open, crosshairHUD.open)
    XCTAssertEqual(high, crosshairHUD.high)
    XCTAssertEqual(low, crosshairHUD.low)
    XCTAssertEqual(close, crosshairHUD.close)
    XCTAssertEqual(volume, crosshairHUD.volume)
  }

  // MARK: - Tests Convert to Dictionary

  func testInitWithDictionary() {
    // Given
    let dictionary: [String: String] = [
      "volume": "843k",
      "high": "96.59",
      "open": "95.66",
      "close": "95.79",
      "low": "95.49"
    ]

    // When
    let crosshairHUD = ChartIQCrosshairHUD(dictionary: dictionary)

    // Then
    XCTAssertEqual(dictionary[Const.CrosshairHUD.openParam], crosshairHUD.open)
    XCTAssertEqual(dictionary[Const.CrosshairHUD.highParam], crosshairHUD.high)
    XCTAssertEqual(dictionary[Const.CrosshairHUD.lowParam], crosshairHUD.low)
    XCTAssertEqual(dictionary[Const.CrosshairHUD.closeParam], crosshairHUD.close)
    XCTAssertEqual(dictionary[Const.CrosshairHUD.volumeParam], crosshairHUD.volume)
  }

  func testInitWithEmptyDictionary() {
    // Given
    let dictionary: [String: String] = [:]

    // When
    let crosshairHUD = ChartIQCrosshairHUD(dictionary: dictionary)

    // Then
    XCTAssertEqual(dictionary[Const.CrosshairHUD.openParam] ?? "", crosshairHUD.open)
    XCTAssertEqual(dictionary[Const.CrosshairHUD.highParam] ?? "", crosshairHUD.high)
    XCTAssertEqual(dictionary[Const.CrosshairHUD.lowParam] ?? "", crosshairHUD.low)
    XCTAssertEqual(dictionary[Const.CrosshairHUD.closeParam] ?? "", crosshairHUD.close)
    XCTAssertEqual(dictionary[Const.CrosshairHUD.volumeParam] ?? "", crosshairHUD.volume)
  }
}
