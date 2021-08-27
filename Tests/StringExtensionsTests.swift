//
//  StringExtensionsTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class StringExtensionsTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Replace String Symbols

  func testReplaceStringWithString() {
    // Given
    let originalString = ">'W'\\< >'Acc'\\< >'Dist'\\<&"
    let correctString = "&gt;&apos;W&apos;\\&lt; &gt;&apos;Acc&apos;\\&lt; &gt;&apos;Dist&apos;\\&lt;&amp;"

    // When
    let stringWithReplacedSymbols = originalString
      .replace(ChartIQSpecialCharacter.ampersand.originalValue, with: ChartIQSpecialCharacter.ampersand.escapingValue)
      .replace(ChartIQSpecialCharacter.doubleQuote.originalValue, with: ChartIQSpecialCharacter.doubleQuote.escapingValue)
      .replace(ChartIQSpecialCharacter.singleQuote.originalValue, with: ChartIQSpecialCharacter.singleQuote.escapingValue)
      .replace(ChartIQSpecialCharacter.lessThan.originalValue, with: ChartIQSpecialCharacter.lessThan.escapingValue)
      .replace(ChartIQSpecialCharacter.greaterThan.originalValue, with: ChartIQSpecialCharacter.greaterThan.escapingValue)

    // Then
    XCTAssertEqual(correctString, stringWithReplacedSymbols)
  }

  func testReplaceStringSymbolWithZwnj() {
    // Given
    var originalString = "|‌AVWAP‌ (,n,n,n)"
    let correctString = "‌AVWAP‌ (,n,n,n)"

    // When
    let stringWithReplacedSymbols = originalString.replaceSymbolWithZwnj(symbol: "|")

    // Then
    XCTAssertEqual(correctString, stringWithReplacedSymbols)
  }

  func testSliceStringFromStringToString() {
    // Given
    let originalString = "\"0.58 (0.53%) 15 Bars\""
    let correctString = "0.58 (0.53%) 15 Bars"

    // When
    let stringWithReplacedSymbols = originalString.slice(from: "\"", to: "\"")

    // Then
    XCTAssertEqual(correctString, stringWithReplacedSymbols)
  }
}
