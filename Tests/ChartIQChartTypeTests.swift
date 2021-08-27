//
//  ChartIQChartTypeTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQChartTypeTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests ChartIQChartType Enum

  func testsChartIQChartTypeEnumGetStringValue() {
    // Given
    let candleString = "candle"
    let barString = "bar"
    let coloredBarString = "colored_bar"
    let lineString = "line"
    let vertexLineString = "vertex_line"
    let stepString = "step"
    let mountainString = "mountain"
    let baselineString = "baseline_delta"
    let hollowCandleString = "hollow_candle"
    let volumeCandleString = "volume_candle"
    let coloredHLCBarString = "colored_hlc"
    let scatterplotString = "scatterplot"
    let histogramString = "histogram"

    // When // Then
    XCTAssertEqual(candleString, ChartIQChartType.candle.stringValue)
    XCTAssertEqual(barString, ChartIQChartType.bar.stringValue)
    XCTAssertEqual(coloredBarString, ChartIQChartType.coloredBar.stringValue)
    XCTAssertEqual(lineString, ChartIQChartType.line.stringValue)
    XCTAssertEqual(vertexLineString, ChartIQChartType.vertexLine.stringValue)
    XCTAssertEqual(stepString, ChartIQChartType.step.stringValue)
    XCTAssertEqual(mountainString, ChartIQChartType.mountain.stringValue)
    XCTAssertEqual(baselineString, ChartIQChartType.baseline.stringValue)
    XCTAssertEqual(hollowCandleString, ChartIQChartType.hollowCandle.stringValue)
    XCTAssertEqual(volumeCandleString, ChartIQChartType.volumeCandle.stringValue)
    XCTAssertEqual(coloredHLCBarString, ChartIQChartType.coloredHLCBar.stringValue)
    XCTAssertEqual(scatterplotString, ChartIQChartType.scatterplot.stringValue)
    XCTAssertEqual(histogramString, ChartIQChartType.histogram.stringValue)
  }

  func testsChartIQChartTypeEnumGetDisplayNameValue() {
    // Given
    let candleString = "Candle"
    let barString = "Bar"
    let coloredBarString = "Colored Bar"
    let lineString = "Line"
    let vertexLineString = "Vertex Line"
    let stepString = "Step"
    let mountainString = "Mountain"
    let baselineString = "Baseline"
    let hollowCandleString = "Hollow Candle"
    let volumeCandleString = "Volume Candle"
    let coloredHLCBarString = "Colored HLC Bar"
    let scatterplotString = "Scatterplot"
    let histogramString = "Histogram"

    // When // Then
    XCTAssertEqual(candleString, ChartIQChartType.candle.displayName)
    XCTAssertEqual(barString, ChartIQChartType.bar.displayName)
    XCTAssertEqual(coloredBarString, ChartIQChartType.coloredBar.displayName)
    XCTAssertEqual(lineString, ChartIQChartType.line.displayName)
    XCTAssertEqual(vertexLineString, ChartIQChartType.vertexLine.displayName)
    XCTAssertEqual(stepString, ChartIQChartType.step.displayName)
    XCTAssertEqual(mountainString, ChartIQChartType.mountain.displayName)
    XCTAssertEqual(baselineString, ChartIQChartType.baseline.displayName)
    XCTAssertEqual(hollowCandleString, ChartIQChartType.hollowCandle.displayName)
    XCTAssertEqual(volumeCandleString, ChartIQChartType.volumeCandle.displayName)
    XCTAssertEqual(coloredHLCBarString, ChartIQChartType.coloredHLCBar.displayName)
    XCTAssertEqual(scatterplotString, ChartIQChartType.scatterplot.displayName)
    XCTAssertEqual(histogramString, ChartIQChartType.histogram.displayName)
  }

  func testsChartIQChartTypeEnumInitWithStringValue() {
    // Given
    let candleString = "candle"
    let barString = "bar"
    let coloredBarString = "colored_bar"
    let lineString = "line"
    let vertexLineString = "vertex_line"
    let stepString = "step"
    let mountainString = "mountain"
    let baselineString = "baseline_delta"
    let hollowCandleString = "hollow_candle"
    let volumeCandleString = "volume_candle"
    let coloredHLCBarString = "colored_hlc"
    let scatterplotString = "scatterplot"
    let histogramString = "histogram"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQChartType.candle, ChartIQChartType(stringValue: candleString))
    XCTAssertEqual(ChartIQChartType.bar, ChartIQChartType(stringValue: barString))
    XCTAssertEqual(ChartIQChartType.coloredBar, ChartIQChartType(stringValue: coloredBarString))
    XCTAssertEqual(ChartIQChartType.line, ChartIQChartType(stringValue: lineString))
    XCTAssertEqual(ChartIQChartType.vertexLine, ChartIQChartType(stringValue: vertexLineString))
    XCTAssertEqual(ChartIQChartType.step, ChartIQChartType(stringValue: stepString))
    XCTAssertEqual(ChartIQChartType.mountain, ChartIQChartType(stringValue: mountainString))
    XCTAssertEqual(ChartIQChartType.baseline, ChartIQChartType(stringValue: baselineString))
    XCTAssertEqual(ChartIQChartType.hollowCandle, ChartIQChartType(stringValue: hollowCandleString))
    XCTAssertEqual(ChartIQChartType.volumeCandle, ChartIQChartType(stringValue: volumeCandleString))
    XCTAssertEqual(ChartIQChartType.coloredHLCBar, ChartIQChartType(stringValue: coloredHLCBarString))
    XCTAssertEqual(ChartIQChartType.scatterplot, ChartIQChartType(stringValue: scatterplotString))
    XCTAssertEqual(ChartIQChartType.histogram, ChartIQChartType(stringValue: histogramString))

    XCTAssertNil(ChartIQChartType(stringValue: invalidString))
  }

  // MARK: - Tests ChartIQChartAggregationType Enum

  func testsChartIQChartAggregationTypeEnumGetStringValue() {
    // Given
    let heikinashiString = "heikinashi"
    let kagiString = "kagi"
    let linebreakString = "linebreak"
    let renkoString = "renko"
    let rangebarsString = "rangebars"
    let pandfString = "pandf"

    // When // Then
    XCTAssertEqual(heikinashiString, ChartIQChartAggregationType.heikinashi.stringValue)
    XCTAssertEqual(kagiString, ChartIQChartAggregationType.kagi.stringValue)
    XCTAssertEqual(linebreakString, ChartIQChartAggregationType.linebreak.stringValue)
    XCTAssertEqual(renkoString, ChartIQChartAggregationType.renko.stringValue)
    XCTAssertEqual(rangebarsString, ChartIQChartAggregationType.rangebars.stringValue)
    XCTAssertEqual(pandfString, ChartIQChartAggregationType.pandf.stringValue)
  }

  func testsChartIQChartAggregationTypeEnumGetDisplayNameValue() {
    // Given
    let heikinashiString = "Heikin Ashi"
    let kagiString = "Kagi"
    let linebreakString = "Line Break"
    let renkoString = "Renko"
    let rangebarsString = "Range Bars"
    let pandfString = "Point & Figure"

    // When // Then
    XCTAssertEqual(heikinashiString, ChartIQChartAggregationType.heikinashi.displayName)
    XCTAssertEqual(kagiString, ChartIQChartAggregationType.kagi.displayName)
    XCTAssertEqual(linebreakString, ChartIQChartAggregationType.linebreak.displayName)
    XCTAssertEqual(renkoString, ChartIQChartAggregationType.renko.displayName)
    XCTAssertEqual(rangebarsString, ChartIQChartAggregationType.rangebars.displayName)
    XCTAssertEqual(pandfString, ChartIQChartAggregationType.pandf.displayName)
  }

  func testsChartIQChartAggregationTypeEnumInitWithStringValue() {
    // Given
    let heikinashiString = "heikinashi"
    let kagiString = "kagi"
    let linebreakString = "linebreak"
    let renkoString = "renko"
    let rangebarsString = "rangebars"
    let pandfString = "pandf"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQChartAggregationType.heikinashi, ChartIQChartAggregationType(stringValue: heikinashiString))
    XCTAssertEqual(ChartIQChartAggregationType.kagi, ChartIQChartAggregationType(stringValue: kagiString))
    XCTAssertEqual(ChartIQChartAggregationType.linebreak, ChartIQChartAggregationType(stringValue: linebreakString))
    XCTAssertEqual(ChartIQChartAggregationType.renko, ChartIQChartAggregationType(stringValue: renkoString))
    XCTAssertEqual(ChartIQChartAggregationType.rangebars, ChartIQChartAggregationType(stringValue: rangebarsString))
    XCTAssertEqual(ChartIQChartAggregationType.pandf, ChartIQChartAggregationType(stringValue: pandfString))

    XCTAssertNil(ChartIQChartAggregationType(stringValue: invalidString))
  }
}
