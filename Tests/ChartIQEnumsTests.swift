//
//  ChartIQEnumsTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
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

  // MARK: - ChartIQStudyError

  // MARK: - ChartIQFontFamily

  func testsChartIQFontFamilyEnumGetDisplayNameValue() {
    // Given
    let defaultString = "Default"
    let helvetica = "Helvetica"
    let courier = "Courier"
    let garamond = "Garamond"
    let palatino = "Palatino"
    let timesNewRoman = "Times New Roman"

    // When // Then
    XCTAssertEqual(defaultString, ChartIQFontFamily.default.displayName)
    XCTAssertEqual(helvetica, ChartIQFontFamily.helvetica.displayName)
    XCTAssertEqual(courier, ChartIQFontFamily.courier.displayName)
    XCTAssertEqual(garamond, ChartIQFontFamily.garamond.displayName)
    XCTAssertEqual(palatino, ChartIQFontFamily.palatino.displayName)
    XCTAssertEqual(timesNewRoman, ChartIQFontFamily.timesNewRoman.displayName)
  }

  // MARK: - ChartIQFontSize

  func testsChartIQFontSizeEnumGetDisplayNameValue() {
    // Given
    let fontOfSize8 = "8px"
    let fontOfSize10 = "10px"
    let fontOfSize12 = "12px"
    let fontOfSize13 = "13px"
    let fontOfSize14 = "14px"
    let fontOfSize16 = "16px"
    let fontOfSize20 = "20px"
    let fontOfSize28 = "28px"
    let fontOfSize36 = "36px"
    let fontOfSize48 = "48px"
    let fontOfSize64 = "64px"

    // When // Then
    XCTAssertEqual(fontOfSize8, ChartIQFontSize.fontOfSize8.displayName)
    XCTAssertEqual(fontOfSize10, ChartIQFontSize.fontOfSize10.displayName)
    XCTAssertEqual(fontOfSize12, ChartIQFontSize.fontOfSize12.displayName)
    XCTAssertEqual(fontOfSize13, ChartIQFontSize.fontOfSize13.displayName)
    XCTAssertEqual(fontOfSize14, ChartIQFontSize.fontOfSize14.displayName)
    XCTAssertEqual(fontOfSize16, ChartIQFontSize.fontOfSize16.displayName)
    XCTAssertEqual(fontOfSize20, ChartIQFontSize.fontOfSize20.displayName)
    XCTAssertEqual(fontOfSize28, ChartIQFontSize.fontOfSize28.displayName)
    XCTAssertEqual(fontOfSize36, ChartIQFontSize.fontOfSize36.displayName)
    XCTAssertEqual(fontOfSize48, ChartIQFontSize.fontOfSize48.displayName)
    XCTAssertEqual(fontOfSize64, ChartIQFontSize.fontOfSize64.displayName)
  }

  // MARK: - ChartIQFontStyle

  func testsChartIQFontStyleEnumGetDisplayNameValue() {
    // Given
    let none = "None"
    let bold = "Bold"
    let italic = "Italic"

    // When // Then
    XCTAssertEqual(none, ChartIQFontStyle.none.displayName)
    XCTAssertEqual(bold, ChartIQFontStyle.bold.displayName)
    XCTAssertEqual(italic, ChartIQFontStyle.italic.displayName)
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

  // MARK: - ChartIQTheme

  func testsChartIQThemeEnumGetStringValue() {
    // Given
    let day = "day"
    let night = "night"
    let none = "none"

    // When // Then
    XCTAssertEqual(day, ChartIQTheme.day.stringValue)
    XCTAssertEqual(night, ChartIQTheme.night.stringValue)
    XCTAssertEqual(none, ChartIQTheme.none.stringValue)
  }

  // MARK: - ChartIQLayer

  func testsChartIQLayerEnumGetStringValue() {
    // Given
    let top = "top"
    let up = "up"
    let back = "back"
    let bottom = "bottom"

    // When // Then
    XCTAssertEqual(top, ChartIQLayer.top.stringValue)
    XCTAssertEqual(up, ChartIQLayer.up.stringValue)
    XCTAssertEqual(back, ChartIQLayer.back.stringValue)
    XCTAssertEqual(bottom, ChartIQLayer.bottom.stringValue)
  }

  // MARK: - ChartIQQuoteField

  func testsChartIQQuoteFieldEnumGetStringValue() {
    // Given
    let date = "Date"
    let close = "Close"
    let open = "Open"
    let high = "High"
    let low = "Low"
    let volume = "Volume"

    // When // Then
    XCTAssertEqual(date, ChartIQQuoteField.date.stringValue)
    XCTAssertEqual(close, ChartIQQuoteField.close.stringValue)
    XCTAssertEqual(open, ChartIQQuoteField.open.stringValue)
    XCTAssertEqual(high, ChartIQQuoteField.high.stringValue)
    XCTAssertEqual(low, ChartIQQuoteField.low.stringValue)
    XCTAssertEqual(volume, ChartIQQuoteField.volume.stringValue)
  }

  func testsChartIQQuoteFieldEnumGetDisplayNameValue() {
    // Given
    let date = "Date"
    let close = "Close"
    let open = "Open"
    let high = "High"
    let low = "Low"
    let volume = "Volume"

    // When // Then
    XCTAssertEqual(date, ChartIQQuoteField.date.displayName)
    XCTAssertEqual(close, ChartIQQuoteField.close.displayName)
    XCTAssertEqual(open, ChartIQQuoteField.open.displayName)
    XCTAssertEqual(high, ChartIQQuoteField.high.displayName)
    XCTAssertEqual(low, ChartIQQuoteField.low.displayName)
    XCTAssertEqual(volume, ChartIQQuoteField.volume.displayName)
  }

  // MARK: - ChartIQStudyParametersType

  func testsChartIQStudyParametersTypeEnumGetStringValue() {
    // Given
    let inputs = "inputs"
    let outputs = "outputs"
    let parameters = "parameters"

    // When // Then
    XCTAssertEqual(inputs, ChartIQStudyParametersType.inputs.stringValue)
    XCTAssertEqual(outputs, ChartIQStudyParametersType.outputs.stringValue)
    XCTAssertEqual(parameters, ChartIQStudyParametersType.parameters.stringValue)
  }

  // MARK: - ChartIQTimeUnit

  func testsChartIQTimeUnitEnumGetStringValue() {
    // Given
    let tick = "tick"
    let millisecond = "millisecond"
    let second = "second"
    let minute = "minute"
    let day = "day"
    let week = "week"
    let month = "month"

    // When // Then
    XCTAssertEqual(tick, ChartIQTimeUnit.tick.stringValue)
    XCTAssertEqual(millisecond, ChartIQTimeUnit.millisecond.stringValue)
    XCTAssertEqual(second, ChartIQTimeUnit.second.stringValue)
    XCTAssertEqual(minute, ChartIQTimeUnit.minute.stringValue)
    XCTAssertEqual(day, ChartIQTimeUnit.day.stringValue)
    XCTAssertEqual(week, ChartIQTimeUnit.week.stringValue)
    XCTAssertEqual(month, ChartIQTimeUnit.month.stringValue)
  }

  func testsChartIQTimeUnitEnumInitWithStringValue() {
    // Given
    let tick = "tick"
    let millisecond = "millisecond"
    let second = "second"
    let minute = "minute"
    let day = "day"
    let week = "week"
    let month = "month"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQTimeUnit.tick, ChartIQTimeUnit(stringValue: tick))
    XCTAssertEqual(ChartIQTimeUnit.millisecond, ChartIQTimeUnit(stringValue: millisecond))
    XCTAssertEqual(ChartIQTimeUnit.second, ChartIQTimeUnit(stringValue: second))
    XCTAssertEqual(ChartIQTimeUnit.minute, ChartIQTimeUnit(stringValue: minute))
    XCTAssertEqual(ChartIQTimeUnit.day, ChartIQTimeUnit(stringValue: day))
    XCTAssertEqual(ChartIQTimeUnit.week, ChartIQTimeUnit(stringValue: week))
    XCTAssertEqual(ChartIQTimeUnit.month, ChartIQTimeUnit(stringValue: month))

    XCTAssertNil(ChartIQTimeUnit(stringValue: invalidString))
  }

  // MARK: - ChartIQCallbackMessage

  func testsChartIQCallbackMessageEnumGetStringValue() {
    // Given
    let newSymbol = "newSymbolCallbackHandler"
    let pullInitialData = "pullInitialDataHandler"
    let pullUpdateData = "pullUpdateDataHandler"
    let pullPaginationData = "pullPaginationDataHandler"
    let layout = "layoutHandler"
    let drawing = "drawingHandler"
    let measure = "measureHandler"
    let accessibility = "accessibilityHandler"
    let log = "logHandler"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(newSymbol, ChartIQCallbackMessage.newSymbol.stringValue)
    XCTAssertEqual(pullInitialData, ChartIQCallbackMessage.pullInitialData.stringValue)
    XCTAssertEqual(pullUpdateData, ChartIQCallbackMessage.pullUpdateData.stringValue)
    XCTAssertEqual(pullPaginationData, ChartIQCallbackMessage.pullPaginationData.stringValue)
    XCTAssertEqual(layout, ChartIQCallbackMessage.layout.stringValue)
    XCTAssertEqual(drawing, ChartIQCallbackMessage.drawing.stringValue)
    XCTAssertEqual(measure, ChartIQCallbackMessage.measure.stringValue)
    XCTAssertEqual(accessibility, ChartIQCallbackMessage.accessibility.stringValue)
    XCTAssertEqual(log, ChartIQCallbackMessage.log.stringValue)

    XCTAssertNil(ChartIQCallbackMessage(stringValue: invalidString))
  }

  func testsChartIQCallbackMessageEnumInitWithStringValue() {
    // Given
    let newSymbol = "newSymbolCallbackHandler"
    let pullInitialData = "pullInitialDataHandler"
    let pullUpdateData = "pullUpdateDataHandler"
    let pullPaginationData = "pullPaginationDataHandler"
    let layout = "layoutHandler"
    let drawing = "drawingHandler"
    let measure = "measureHandler"
    let accessibility = "accessibilityHandler"
    let log = "logHandler"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQCallbackMessage.newSymbol, ChartIQCallbackMessage(stringValue: newSymbol))
    XCTAssertEqual(ChartIQCallbackMessage.pullInitialData, ChartIQCallbackMessage(stringValue: pullInitialData))
    XCTAssertEqual(ChartIQCallbackMessage.pullUpdateData, ChartIQCallbackMessage(stringValue: pullUpdateData))
    XCTAssertEqual(ChartIQCallbackMessage.pullPaginationData, ChartIQCallbackMessage(stringValue: pullPaginationData))
    XCTAssertEqual(ChartIQCallbackMessage.layout, ChartIQCallbackMessage(stringValue: layout))
    XCTAssertEqual(ChartIQCallbackMessage.drawing, ChartIQCallbackMessage(stringValue: drawing))
    XCTAssertEqual(ChartIQCallbackMessage.measure, ChartIQCallbackMessage(stringValue: measure))
    XCTAssertEqual(ChartIQCallbackMessage.accessibility, ChartIQCallbackMessage(stringValue: accessibility))
    XCTAssertEqual(ChartIQCallbackMessage.log, ChartIQCallbackMessage(stringValue: log))

    XCTAssertNil(ChartIQTimeUnit(stringValue: invalidString))
  }

  // MARK: - ChartIQSpecialCharacter

  func testsChartIQSpecialCharacterEnumGetStringValue() {
    // Given
    let ampersand = "ampersand"
    let doubleQuote = "doubleQuote"
    let singleQuote = "singleQuote"
    let lessThan = "lessThan"
    let greaterThan = "greaterThan"

    // When // Then
    XCTAssertEqual(ampersand, ChartIQSpecialCharacter.ampersand.stringValue)
    XCTAssertEqual(doubleQuote, ChartIQSpecialCharacter.doubleQuote.stringValue)
    XCTAssertEqual(singleQuote, ChartIQSpecialCharacter.singleQuote.stringValue)
    XCTAssertEqual(lessThan, ChartIQSpecialCharacter.lessThan.stringValue)
    XCTAssertEqual(greaterThan, ChartIQSpecialCharacter.greaterThan.stringValue)
  }

  func testsChartIQSpecialCharacterEnumGetOriginalValue() {
    // Given
    let ampersand = "&"
    let doubleQuote = "\""
    let singleQuote = "'"
    let lessThan = "<"
    let greaterThan = ">"

    // When // Then
    XCTAssertEqual(ampersand, ChartIQSpecialCharacter.ampersand.originalValue)
    XCTAssertEqual(doubleQuote, ChartIQSpecialCharacter.doubleQuote.originalValue)
    XCTAssertEqual(singleQuote, ChartIQSpecialCharacter.singleQuote.originalValue)
    XCTAssertEqual(lessThan, ChartIQSpecialCharacter.lessThan.originalValue)
    XCTAssertEqual(greaterThan, ChartIQSpecialCharacter.greaterThan.originalValue)
  }

  func testsChartIQSpecialCharacterEnumGetEscapingValue() {
    // Given
    let ampersand = "&amp;"
    let doubleQuote = "&quot;"
    let singleQuote = "&apos;"
    let lessThan = "&lt;"
    let greaterThan = "&gt;"

    // When // Then
    XCTAssertEqual(ampersand, ChartIQSpecialCharacter.ampersand.escapingValue)
    XCTAssertEqual(doubleQuote, ChartIQSpecialCharacter.doubleQuote.escapingValue)
    XCTAssertEqual(singleQuote, ChartIQSpecialCharacter.singleQuote.escapingValue)
    XCTAssertEqual(lessThan, ChartIQSpecialCharacter.lessThan.escapingValue)
    XCTAssertEqual(greaterThan, ChartIQSpecialCharacter.greaterThan.escapingValue)
  }
}
