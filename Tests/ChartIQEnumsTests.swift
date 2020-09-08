//
//  ChartIQEnumsTests.swift
//  ChartIQTests
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQEnumsTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests ChartIQDataMethod Enum

  // MARK: - Tests ChartIQScale Enum

  func testsChartIQScaleEnumGetStringValue() {
    // Given
    let logString = "log"
    let linearString = "linear"

    // When // Then
    XCTAssertEqual(logString, ChartIQScale.log.stringValue)
    XCTAssertEqual(linearString, ChartIQScale.linear.stringValue)
  }

  func testsChartIQScaleEnumInitWithStringValue() {
    // Given
    let logString = "log"
    let linearString = "linear"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQScale.log, ChartIQScale(stringValue: logString))
    XCTAssertEqual(ChartIQScale.linear, ChartIQScale(stringValue: linearString))

    XCTAssertNil(ChartIQScale(stringValue: invalidString))
  }

  // MARK: - Tests ChartIQDrawingToolType Enum

  func testsChartIQDrawingToolTypeEnumGetDisplayNameValue() {
    // Given
    let text = "Text"
    let statistics = "Statistics"
    let technicals = "Technicals"
    let fibonacci = "Fibonacci"
    let markings = "Markings"
    let lines = "Lines"

    // When // Then
    XCTAssertEqual(text, ChartIQDrawingToolType.text.displayName)
    XCTAssertEqual(statistics, ChartIQDrawingToolType.statistics.displayName)
    XCTAssertEqual(technicals, ChartIQDrawingToolType.technicals.displayName)
    XCTAssertEqual(fibonacci, ChartIQDrawingToolType.fibonacci.displayName)
    XCTAssertEqual(markings, ChartIQDrawingToolType.markings.displayName)
    XCTAssertEqual(lines, ChartIQDrawingToolType.lines.displayName)
  }

  // MARK: - Tests ChartIQLineType Enum

  func testsChartIQLineTypeEnumGetStringValue() {
    // Given
    let solid = "solid"
    let dotted = "dotted"
    let dashed = "dashed"

    // When // Then
    XCTAssertEqual(solid, ChartIQLineType.solid.stringValue)
    XCTAssertEqual(dotted, ChartIQLineType.dotted.stringValue)
    XCTAssertEqual(dashed, ChartIQLineType.dashed.stringValue)
  }

  func testsChartIQLineTypeEnumInitWithStringValue() {
    // Given
    let solid = "solid"
    let dotted = "dotted"
    let dashed = "dashed"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQLineType.solid, ChartIQLineType(stringValue: solid))
    XCTAssertEqual(ChartIQLineType.dotted, ChartIQLineType(stringValue: dotted))
    XCTAssertEqual(ChartIQLineType.dashed, ChartIQLineType(stringValue: dashed))

    XCTAssertNil(ChartIQLineType(stringValue: invalidString))
  }
}
