//
//  ChartIQElliottWaveTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQElliottWaveTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests ChartIQElliottWaveTemplate Enum

  func testsChartIQElliottWaveTemplateEnumGetDisplayNameValue() {
    // Given
    let grandSupercycle = "Grand Supercycle"
    let supercycle = "Supercycle"
    let cycle = "Cycle"
    let primary = "Primary"
    let intermediate = "Intermediate"
    let minor = "Minor"
    let minute = "Minute"
    let minuette = "Minuette"
    let subMinuette = "Sub-Minuette"
    let custom = "Custom"

    // When // Then
    XCTAssertEqual(grandSupercycle, ChartIQElliottWaveTemplate.grandSupercycle.displayName)
    XCTAssertEqual(supercycle, ChartIQElliottWaveTemplate.supercycle.displayName)
    XCTAssertEqual(cycle, ChartIQElliottWaveTemplate.cycle.displayName)
    XCTAssertEqual(primary, ChartIQElliottWaveTemplate.primary.displayName)
    XCTAssertEqual(intermediate, ChartIQElliottWaveTemplate.intermediate.displayName)
    XCTAssertEqual(minor, ChartIQElliottWaveTemplate.minor.displayName)
    XCTAssertEqual(minute, ChartIQElliottWaveTemplate.minute.displayName)
    XCTAssertEqual(minuette, ChartIQElliottWaveTemplate.minuette.displayName)
    XCTAssertEqual(subMinuette, ChartIQElliottWaveTemplate.subMinuette.displayName)
    XCTAssertEqual(custom, ChartIQElliottWaveTemplate.custom.displayName)
  }

  // MARK: - Tests ChartIQElliottWaveImpulse Enum

  func testsChartIQElliottWaveImpulseEnumGetDisplayNameValue() {
    // Given
    let none = "- - -"
    let romanCapital = "I II III IV V"
    let romanNormal = "i ii iii iv v"
    let arabicNormal = "1 2 3 4 5"
    let abcdeCapital = "A B C D E"
    let abcdeNormal = "a b c d e"
    let wxyxzCapital = "W X Y X Z"
    let wxyxzNormal = "w x y x z"

    // When // Then
    XCTAssertEqual(none, ChartIQElliottWaveImpulse.none.displayName)
    XCTAssertEqual(romanCapital, ChartIQElliottWaveImpulse.romanCapital.displayName)
    XCTAssertEqual(romanNormal, ChartIQElliottWaveImpulse.romanNormal.displayName)
    XCTAssertEqual(arabicNormal, ChartIQElliottWaveImpulse.arabicNormal.displayName)
    XCTAssertEqual(abcdeCapital, ChartIQElliottWaveImpulse.abcdeCapital.displayName)
    XCTAssertEqual(abcdeNormal, ChartIQElliottWaveImpulse.abcdeNormal.displayName)
    XCTAssertEqual(wxyxzCapital, ChartIQElliottWaveImpulse.wxyxzCapital.displayName)
    XCTAssertEqual(wxyxzNormal, ChartIQElliottWaveImpulse.wxyxzNormal.displayName)
  }

  // MARK: - Tests ChartIQElliottWaveCorrective Enum

  func testsChartIQElliottWaveCorrectiveEnumGetDisplayNameValue() {
    // Given
    let none = "- - -"
    let abcCapital = "A B C"
    let abcNormal = "a b c"
    let wxyCapital = "W X Y"
    let wxyNormal = "w x y"

    // When // Then
    XCTAssertEqual(none, ChartIQElliottWaveCorrective.none.displayName)
    XCTAssertEqual(abcCapital, ChartIQElliottWaveCorrective.abcCapital.displayName)
    XCTAssertEqual(abcNormal, ChartIQElliottWaveCorrective.abcNormal.displayName)
    XCTAssertEqual(wxyCapital, ChartIQElliottWaveCorrective.wxyCapital.displayName)
    XCTAssertEqual(wxyNormal, ChartIQElliottWaveCorrective.wxyNormal.displayName)
  }

  // MARK: - Tests ChartIQElliottWaveDecoration Enum

  func testsChartIQElliottWaveDecorationEnumGetDisplayNameValue() {
    // Given
    let none = "None"
    let parentheses = "Parentheses"
    let enclosed = "Enclosed"

    // When // Then
    XCTAssertEqual(none, ChartIQElliottWaveDecoration.none.displayName)
    XCTAssertEqual(parentheses, ChartIQElliottWaveDecoration.parentheses.displayName)
    XCTAssertEqual(enclosed, ChartIQElliottWaveDecoration.enclosed.displayName)
  }
}
