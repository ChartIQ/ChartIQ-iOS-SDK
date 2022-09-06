//
//  ChartIQSignalEnumsTests.swift
//  ChartIQTests
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQSignalEnumsTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - ChartIQSignalOperator Enum

  func testsChartIQSignalOperatorGetStringValue() {
    // Given
    let isGreaterThan = ">"
    let isLessThan = "<"
    let isEqualTo = "="
    let crosses = "x"
    let crossesAbove = "x+"
    let crossesBelow = "x-"
    let turnsUp = "t+"
    let turnsDown = "t-"
    let increases = ">p"
    let decreases = "<p"
    let doesNotChange = "=p"

    // When // Then
    XCTAssertEqual(isGreaterThan, ChartIQSignalOperator.isGreaterThan.stringValue)
    XCTAssertEqual(isLessThan, ChartIQSignalOperator.isLessThan.stringValue)
    XCTAssertEqual(isEqualTo, ChartIQSignalOperator.isEqualTo.stringValue)
    XCTAssertEqual(crosses, ChartIQSignalOperator.crosses.stringValue)
    XCTAssertEqual(crossesAbove, ChartIQSignalOperator.crossesAbove.stringValue)
    XCTAssertEqual(crossesBelow, ChartIQSignalOperator.crossesBelow.stringValue)
    XCTAssertEqual(turnsUp, ChartIQSignalOperator.turnsUp.stringValue)
    XCTAssertEqual(turnsDown, ChartIQSignalOperator.turnsDown.stringValue)
    XCTAssertEqual(increases, ChartIQSignalOperator.increases.stringValue)
    XCTAssertEqual(decreases, ChartIQSignalOperator.decreases.stringValue)
    XCTAssertEqual(doesNotChange, ChartIQSignalOperator.doesNotChange.stringValue)
  }

  func testsChartIQSignalOperatorGetDisplayNameValue() {
    // Given
    let isGreaterThan = "Is Greater Than"
    let isLessThan = "Is Less Than"
    let isEqualTo = "Is Equal To"
    let crosses = "Crosses"
    let crossesAbove = "Crosses Above"
    let crossesBelow = "Crosses Below"
    let turnsUp = "Turns Up"
    let turnsDown = "Turns Down"
    let increases = "Increases"
    let decreases = "Decreases"
    let doesNotChange = "Does Not Change"

    // When // Then
    XCTAssertEqual(isGreaterThan, ChartIQSignalOperator.isGreaterThan.displayName)
    XCTAssertEqual(isLessThan, ChartIQSignalOperator.isLessThan.displayName)
    XCTAssertEqual(isEqualTo, ChartIQSignalOperator.isEqualTo.displayName)
    XCTAssertEqual(crosses, ChartIQSignalOperator.crosses.displayName)
    XCTAssertEqual(crossesAbove, ChartIQSignalOperator.crossesAbove.displayName)
    XCTAssertEqual(crossesBelow, ChartIQSignalOperator.crossesBelow.displayName)
    XCTAssertEqual(turnsUp, ChartIQSignalOperator.turnsUp.displayName)
    XCTAssertEqual(turnsDown, ChartIQSignalOperator.turnsDown.displayName)
    XCTAssertEqual(increases, ChartIQSignalOperator.increases.displayName)
    XCTAssertEqual(decreases, ChartIQSignalOperator.decreases.displayName)
    XCTAssertEqual(doesNotChange, ChartIQSignalOperator.doesNotChange.displayName)
  }

  func testsChartIQSignalOperatorInitWithStringValue() {
    // Given
    let isGreaterThan = ">"
    let isLessThan = "<"
    let isEqualTo = "="
    let crosses = "x"
    let crossesAbove = "x+"
    let crossesBelow = "x-"
    let turnsUp = "t+"
    let turnsDown = "t-"
    let increases = ">p"
    let decreases = "<p"
    let doesNotChange = "=p"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQSignalOperator.isGreaterThan, ChartIQSignalOperator(stringValue: isGreaterThan))
    XCTAssertEqual(ChartIQSignalOperator.isLessThan, ChartIQSignalOperator(stringValue: isLessThan))
    XCTAssertEqual(ChartIQSignalOperator.isEqualTo, ChartIQSignalOperator(stringValue: isEqualTo))
    XCTAssertEqual(ChartIQSignalOperator.crosses, ChartIQSignalOperator(stringValue: crosses))
    XCTAssertEqual(ChartIQSignalOperator.crossesAbove, ChartIQSignalOperator(stringValue: crossesAbove))
    XCTAssertEqual(ChartIQSignalOperator.crossesBelow, ChartIQSignalOperator(stringValue: crossesBelow))
    XCTAssertEqual(ChartIQSignalOperator.turnsUp, ChartIQSignalOperator(stringValue: turnsUp))
    XCTAssertEqual(ChartIQSignalOperator.turnsDown, ChartIQSignalOperator(stringValue: turnsDown))
    XCTAssertEqual(ChartIQSignalOperator.increases, ChartIQSignalOperator(stringValue: increases))
    XCTAssertEqual(ChartIQSignalOperator.decreases, ChartIQSignalOperator(stringValue: decreases))
    XCTAssertEqual(ChartIQSignalOperator.doesNotChange, ChartIQSignalOperator(stringValue: doesNotChange))

    XCTAssertNil(ChartIQSignalOperator(stringValue: invalidString))
  }

  // MARK: - ChartIQSignalShape Enum

  func testsChartIQSignalShapeGetStringValue() {
    // Given
    let circle = "circle"
    let square = "square"
    let diamond = "diamond"

    // When // Then
    XCTAssertEqual(circle, ChartIQSignalShape.circle.stringValue)
    XCTAssertEqual(square, ChartIQSignalShape.square.stringValue)
    XCTAssertEqual(diamond, ChartIQSignalShape.diamond.stringValue)
  }

  func testsChartIQSignalShapeGetDisplayNameValue() {
    // Given
    let circle = "Circle"
    let square = "Square"
    let diamond = "Diamond"

    // When // Then
    XCTAssertEqual(circle, ChartIQSignalShape.circle.displayName)
    XCTAssertEqual(square, ChartIQSignalShape.square.displayName)
    XCTAssertEqual(diamond, ChartIQSignalShape.diamond.displayName)
  }

  func testsChartIQSignalShapeInitWithStringValue() {
    // Given
    let circle = "circle"
    let square = "square"
    let diamond = "diamond"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQSignalShape.circle, ChartIQSignalShape(stringValue: circle))
    XCTAssertEqual(ChartIQSignalShape.square, ChartIQSignalShape(stringValue: square))
    XCTAssertEqual(ChartIQSignalShape.diamond, ChartIQSignalShape(stringValue: diamond))

    XCTAssertNil(ChartIQSignalShape(stringValue: invalidString))
  }

  // MARK: - ChartIQSignalSize Enum

  func testsChartIQSignalSizeGetStringValue() {
    // Given
    let small = "S"
    let medium = "M"
    let large = "L"

    // When // Then
    XCTAssertEqual(small, ChartIQSignalSize.small.stringValue)
    XCTAssertEqual(medium, ChartIQSignalSize.medium.stringValue)
    XCTAssertEqual(large, ChartIQSignalSize.large.stringValue)
  }

  func testsChartIQSignalSizeGetDisplayNameValue() {
    // Given
    let small = "Small"
    let medium = "Medium"
    let large = "Large"

    // When // Then
    XCTAssertEqual(small, ChartIQSignalSize.small.displayName)
    XCTAssertEqual(medium, ChartIQSignalSize.medium.displayName)
    XCTAssertEqual(large, ChartIQSignalSize.large.displayName)
  }

  func testsChartIQSignalSizeInitWithStringValue() {
    // Given
    let small = "S"
    let medium = "M"
    let large = "L"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQSignalSize.small, ChartIQSignalSize(stringValue: small))
    XCTAssertEqual(ChartIQSignalSize.medium, ChartIQSignalSize(stringValue: medium))
    XCTAssertEqual(ChartIQSignalSize.large, ChartIQSignalSize(stringValue: large))

    XCTAssertNil(ChartIQSignalSize(stringValue: invalidString))
  }

  // MARK: - ChartIQSignalPosition Enum

  func testsChartIQSignalPositionGetStringValue() {
    // Given
    let aboveCandle = "above_candle"
    let belowCandle = "below_candle"
    let onCandle = "on_candle"

    // When // Then
    XCTAssertEqual(aboveCandle, ChartIQSignalPosition.aboveCandle.stringValue)
    XCTAssertEqual(belowCandle, ChartIQSignalPosition.belowCandle.stringValue)
    XCTAssertEqual(onCandle, ChartIQSignalPosition.onCandle.stringValue)
  }

  func testsChartIQSignalPositionGetDisplayNameValue() {
    // Given
    let aboveCandle = "Above Line"
    let belowCandle = "Below Line"
    let onCandle = "On Line"

    // When // Then
    XCTAssertEqual(aboveCandle, ChartIQSignalPosition.aboveCandle.displayName)
    XCTAssertEqual(belowCandle, ChartIQSignalPosition.belowCandle.displayName)
    XCTAssertEqual(onCandle, ChartIQSignalPosition.onCandle.displayName)
  }

  func testsChartIQSignalPositionInitWithStringValue() {
    // Given
    let aboveCandle = "above_candle"
    let belowCandle = "below_candle"
    let onCandle = "on_candle"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQSignalPosition.aboveCandle, ChartIQSignalPosition(stringValue: aboveCandle))
    XCTAssertEqual(ChartIQSignalPosition.belowCandle, ChartIQSignalPosition(stringValue: belowCandle))
    XCTAssertEqual(ChartIQSignalPosition.onCandle, ChartIQSignalPosition(stringValue: onCandle))

    XCTAssertNil(ChartIQSignalPosition(stringValue: invalidString))
  }

  // MARK: - ChartIQSignalMarkerType Enum

  func testsChartIQSignalMarkerTypeGetStringValue() {
    // Given
    let marker = "marker"
    let paintbar = "paintbar"

    // When // Then
    XCTAssertEqual(marker, ChartIQSignalMarkerType.marker.stringValue)
    XCTAssertEqual(paintbar, ChartIQSignalMarkerType.paintbar.stringValue)
  }

  func testsChartIQSignalMarkerTypeGetDisplayNameValue() {
    // Given
    let marker = "Chart Marker"
    let paintbar = "Paintbar"

    // When // Then
    XCTAssertEqual(marker, ChartIQSignalMarkerType.marker.displayName)
    XCTAssertEqual(paintbar, ChartIQSignalMarkerType.paintbar.displayName)
  }

  func testsChartIQSignalMarkerTypeInitWithStringValue() {
    // Given
    let marker = "marker"
    let paintbar = "paintbar"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQSignalMarkerType.marker, ChartIQSignalMarkerType(stringValue: marker))
    XCTAssertEqual(ChartIQSignalMarkerType.paintbar, ChartIQSignalMarkerType(stringValue: paintbar))

    XCTAssertNil(ChartIQSignalMarkerType(stringValue: invalidString))
  }

  // MARK: - ChartIQSignalJoiner Enum

  func testsChartIQSignalJoinerGetStringValue() {
    // Given
    let or = "|"
    let and = "&"

    // When // Then
    XCTAssertEqual(or, ChartIQSignalJoiner.or.stringValue)
    XCTAssertEqual(and, ChartIQSignalJoiner.and.stringValue)
  }

  func testsChartIQSignalJoinerGetDisplayNameValue() {
    // Given
    let or = "Or"
    let and = "And"

    // When // Then
    XCTAssertEqual(or, ChartIQSignalJoiner.or.displayName)
    XCTAssertEqual(and, ChartIQSignalJoiner.and.displayName)
  }

  func testsChartIQSignalJoinerInitWithStringValue() {
    // Given
    let or = "|"
    let and = "&"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQSignalJoiner.or, ChartIQSignalJoiner(stringValue: or))
    XCTAssertEqual(ChartIQSignalJoiner.and, ChartIQSignalJoiner(stringValue: and))

    XCTAssertNil(ChartIQSignalJoiner(stringValue: invalidString))
  }
}
