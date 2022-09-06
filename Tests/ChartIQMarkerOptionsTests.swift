//
//  ChartIQMarkerOptionsTests.swift
//  ChartIQTests
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQMarkerOptionsTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testInitWithParameters() {
    // Given
    let markerType: ChartIQSignalMarkerType = .marker
    let color: UIColor = .green
    let shape: ChartIQSignalShape = .diamond
    let label: String = "<"
    let size: ChartIQSignalSize = .small
    let position: ChartIQSignalPosition = .belowCandle

    // When
    let markerOptions = ChartIQMarkerOptions(markerType: markerType,
                                             color: color,
                                             shape: shape,
                                             label: label,
                                             size: size,
                                             position: position)

    // Then
    XCTAssertEqual(markerType, markerOptions.markerType)
    XCTAssertEqual(color, markerOptions.color)
    XCTAssertEqual(shape, markerOptions.shape)
    XCTAssertEqual(label, markerOptions.label)
    XCTAssertEqual(size, markerOptions.size)
    XCTAssertEqual(position, markerOptions.position)
  }

  func testInitWithDictionary() {
    // Given
    let dictionary: [String: Any] = [
      "type": "marker",
      "color": "#0000ff",
      "shape": "circle",
      "label": "X",
      "size": "M",
      "position": "above_candle"
    ]

    // When
    let markerOptions = ChartIQMarkerOptions(dictionary: dictionary)

    // Then
    XCTAssertEqual(dictionary[Const.MarkerOptions.typeParam] as? String, markerOptions?.markerType.stringValue)
    XCTAssertEqual(dictionary[Const.MarkerOptions.colorParam] as? String, markerOptions?.color?.toHexString())
    XCTAssertEqual(dictionary[Const.MarkerOptions.shapeParam] as? String, markerOptions?.shape.stringValue)
    XCTAssertEqual(dictionary[Const.MarkerOptions.labelParam] as? String, markerOptions?.label)
    XCTAssertEqual(dictionary[Const.MarkerOptions.sizeParam] as? String, markerOptions?.size.stringValue)
    XCTAssertEqual(dictionary[Const.MarkerOptions.positionParam] as? String, markerOptions?.position.stringValue)
  }

  func testInitWithDictionaryNil() {
    // Given
    let dictionary: [String: Any] = [
      "color": "#0000ff",
      "shape": "circle",
      "label": "X",
      "size": "M",
      "position": "above_candle"
    ]

    // When
    let markerOptions = ChartIQMarkerOptions(dictionary: dictionary)

    // Then
    XCTAssertNil(markerOptions)
  }

  func testDefaultOptions() {
    // Given
    let markerType: ChartIQSignalMarkerType = .marker
    let color: UIColor? = nil
    let shape: ChartIQSignalShape = .circle
    let label: String = "X"
    let size: ChartIQSignalSize = .medium
    let position: ChartIQSignalPosition = .aboveCandle

    // When
    let markerOptions = ChartIQMarkerOptions.defaultOptions()

    // Then
    XCTAssertEqual(markerType, markerOptions.markerType)
    XCTAssertEqual(color, markerOptions.color)
    XCTAssertEqual(shape, markerOptions.shape)
    XCTAssertEqual(label, markerOptions.label)
    XCTAssertEqual(size, markerOptions.size)
    XCTAssertEqual(position, markerOptions.position)
  }

  func testToDictionary() {
    // Given
    let markerOptions = ChartIQMarkerOptions.defaultOptions()

    // When
    let dictionary = markerOptions.toDictionary()

    // Then
    XCTAssertEqual(dictionary[Const.MarkerOptions.typeParam], markerOptions.markerType.stringValue)
    XCTAssertEqual(dictionary[Const.MarkerOptions.colorParam], String())
    XCTAssertEqual(dictionary[Const.MarkerOptions.shapeParam], markerOptions.shape.stringValue)
    XCTAssertEqual(dictionary[Const.MarkerOptions.labelParam], markerOptions.label)
    XCTAssertEqual(dictionary[Const.MarkerOptions.sizeParam], markerOptions.size.stringValue)
    XCTAssertEqual(dictionary[Const.MarkerOptions.positionParam], markerOptions.position.stringValue)
  }
}
