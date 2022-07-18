//
//  ChartIQConditionTests.swift
//  ChartIQTests
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQConditionTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testInitWithParameters() {
    // Given
    let leftIndicator: String = "Jaw Alligator"
    let `operator`: ChartIQSignalOperator = .isGreaterThan
    let rightIndicator: String = "Lips Alligator"
    let markerOptions: ChartIQMarkerOptions = .defaultOptions()

    // When
    let condition = ChartIQCondition(leftIndicator: leftIndicator,
                                     operator: `operator`,
                                     rightIndicator: rightIndicator,
                                     markerOptions: markerOptions)

    // Then
    XCTAssertEqual(leftIndicator, condition.leftIndicator)
    XCTAssertEqual(`operator`, condition.operator)
    XCTAssertEqual(rightIndicator, condition.rightIndicator)
    XCTAssertEqual(markerOptions, condition.markerOptions)
  }

  func testInitWithArray() {
    // Given
    let array: [Any] = [
      "Jaw Alligator",
      ">",
      "Lips Alligator",
      "",
      [
        "type": "marker",
        "color": "#0000ff",
        "shape": "circle",
        "label": "X",
        "size": "M",
        "position": "above_candle"
      ]
    ]

    // When
    let condition = ChartIQCondition(array: array)

    // Then
    XCTAssertEqual(array[0] as? String, condition?.leftIndicator)
    XCTAssertEqual(array[1] as? String, condition?.operator.stringValue)
    XCTAssertEqual(array[2] as? String, condition?.rightIndicator)
    XCTAssertEqual((array[4] as? [String: Any])?.count, condition?.markerOptions?.toDictionary().count)
  }

  func testInitWithArrayNil() {
    // Given
    let array: [Any] = [
      "Jaw Alligator",
      [
        "color": "#0000ff",
        "shape": "circle",
        "label": "X",
        "size": "M",
        "position": "above_candle"
      ]
    ]

    // When
    let condition = ChartIQCondition(array: array)

    // Then
    XCTAssertNil(condition)
  }

  func testToArray() {
    // Given
    let initialArray: [Any] = [
      "Jaw Alligator",
      ">",
      "Lips Alligator",
      "",
      [
        "type": "marker",
        "color": "#0000ff",
        "shape": "circle",
        "label": "X",
        "size": "M",
        "position": "above_candle"
      ]
    ]

    // When
    let condition = ChartIQCondition(array: initialArray)

    // When
    let array = condition?.toArray()

    // Then
    XCTAssertEqual(array?[0] as? String, condition?.leftIndicator)
    XCTAssertEqual(array?[1] as? String, condition?.operator.stringValue)
    XCTAssertEqual(array?[2] as? String, condition?.rightIndicator)
    XCTAssertEqual((array?[4] as? [String: Any])?.count, condition?.markerOptions?.toDictionary().count)
  }
}
