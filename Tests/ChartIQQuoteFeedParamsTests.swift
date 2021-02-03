//
//  ChartIQQuoteFeedParamsTests.swift
//  ChartIQTests
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQQuoteFeedParamsTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Init with Parameters

  func testInitWithParameters() {
    // Given
    let symbol: String = "AAPL"
    let startDate: String = "2020-03-10T16:42:00.000Z"
    let endDate: String = "2020-03-11T09:32:25.992Z"
    let interval: String = "minute"
    let period: Int = 3

    // When
    let chartIQQuoteFeedParams = ChartIQQuoteFeedParams(symbol: symbol,
                                                        startDate: startDate,
                                                        endDate: endDate,
                                                        interval: interval,
                                                        period: period)

    // Then
    XCTAssertEqual(symbol, chartIQQuoteFeedParams.symbol)
    XCTAssertEqual(startDate, chartIQQuoteFeedParams.startDate)
    XCTAssertEqual(endDate, chartIQQuoteFeedParams.endDate)
    XCTAssertEqual(interval, chartIQQuoteFeedParams.interval)
    XCTAssertEqual(period, chartIQQuoteFeedParams.period)
  }

  // MARK: - Tests Convert to Dictionary

  func testInitWithDictionary() {
    // Given
    let dictionary: [String: Any] = [
      "cb": "K7N4MW0GO8",
      "interval": "minute",
      "symbol": "DJX",
      "startDate": "2020-03-03T20:30:00.000Z",
      "period": 30,
      "endDate": "2020-03-11T09:34:26.615Z"
    ]

    // When
    let chartIQQuoteFeedParams = ChartIQQuoteFeedParams(dictionary: dictionary)

    // Then
    XCTAssertEqual(dictionary[Const.QuoteFeed.symbolParam] as? String, chartIQQuoteFeedParams.symbol)
    XCTAssertEqual(dictionary[Const.QuoteFeed.startDateParam] as? String, chartIQQuoteFeedParams.startDate)
    XCTAssertEqual(dictionary[Const.QuoteFeed.endDateParam] as? String, chartIQQuoteFeedParams.endDate)
    XCTAssertEqual(dictionary[Const.QuoteFeed.intervalParam] as? String, chartIQQuoteFeedParams.interval)
    XCTAssertEqual(dictionary[Const.QuoteFeed.periodParam] as? Int, chartIQQuoteFeedParams.period)
  }

  func testInitWithEmptyDictionary() {
    // Given
    let dictionary: [String: Any] = [:]

    // When
    let chartIQQuoteFeedParams = ChartIQQuoteFeedParams(dictionary: dictionary)

    // Then
    XCTAssertEqual(dictionary[Const.QuoteFeed.symbolParam] as? String ?? "", chartIQQuoteFeedParams.symbol)
    XCTAssertEqual(dictionary[Const.QuoteFeed.startDateParam] as? String ?? "", chartIQQuoteFeedParams.startDate)
    XCTAssertEqual(dictionary[Const.QuoteFeed.endDateParam] as? String ?? "", chartIQQuoteFeedParams.endDate)
    XCTAssertEqual(dictionary[Const.QuoteFeed.intervalParam] as? String ?? "", chartIQQuoteFeedParams.interval)
    XCTAssertEqual(dictionary[Const.QuoteFeed.periodParam] as? Int ?? 0, chartIQQuoteFeedParams.period)
  }
}
