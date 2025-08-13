//
//  ChartIQDrawingToolTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQDrawingToolTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests ChartIQDrawingTool Enum

  func testsChartIQDrawingToolEnumGetStringValue() {
    // Given
    let annotation = "annotation"
    let arrow = "arrowline"
    let average = "average"
    let callout = "callout"
    let channel = "channel"
    let continuous = "continuous"
    let crossline = "crossline"
    let doodle = "freeform"
    let elliottWave = "elliottwave"
    let ellipse = "ellipse"
    let fibArc = "fibarc"
    let fibFan = "fibfan"
    let fibProjection = "fibprojection"
    let fibRetracement = "retracement"
    let fibTimeZone = "fibtimezone"
    let gannFan = "gannfan"
    let gartley = "gartley"
    let horizontal = "horizontal"
    let line = "line"
    let measurementLine = "measurementline"
    let pitchfork = "pitchfork"
    let quadrantLines = "quadrant"
    let ray = "ray"
    let rectangle = "rectangle"
    let regression = "regression"
    let speedResistanceArc = "speedarc"
    let speedResistanceLine = "speedline"
    let timeCycle = "timecycle"
    let tironeLevels = "tirone"
    let trend = "trendline"
    let vertical = "vertical"
    let volumeProfile = "volumeprofile"
    let measure = "measure"

    // When // Then
    XCTAssertEqual(annotation, ChartIQDrawingTool.annotation.stringValue)
    XCTAssertEqual(arrow, ChartIQDrawingTool.arrow.stringValue)
    XCTAssertEqual(average, ChartIQDrawingTool.average.stringValue)
    XCTAssertEqual(callout, ChartIQDrawingTool.callout.stringValue)
    XCTAssertEqual(channel, ChartIQDrawingTool.channel.stringValue)
    XCTAssertEqual(continuous, ChartIQDrawingTool.continuous.stringValue)
    XCTAssertEqual(crossline, ChartIQDrawingTool.crossline.stringValue)
    XCTAssertEqual(doodle, ChartIQDrawingTool.doodle.stringValue)
    XCTAssertEqual(elliottWave, ChartIQDrawingTool.elliottWave.stringValue)
    XCTAssertEqual(ellipse, ChartIQDrawingTool.ellipse.stringValue)
    XCTAssertEqual(fibArc, ChartIQDrawingTool.fibArc.stringValue)
    XCTAssertEqual(fibFan, ChartIQDrawingTool.fibFan.stringValue)
    XCTAssertEqual(fibProjection, ChartIQDrawingTool.fibProjection.stringValue)
    XCTAssertEqual(fibRetracement, ChartIQDrawingTool.fibRetracement.stringValue)
    XCTAssertEqual(fibTimeZone, ChartIQDrawingTool.fibTimeZone.stringValue)
    XCTAssertEqual(gannFan, ChartIQDrawingTool.gannFan.stringValue)
    XCTAssertEqual(gartley, ChartIQDrawingTool.gartley.stringValue)
    XCTAssertEqual(horizontal, ChartIQDrawingTool.horizontal.stringValue)
    XCTAssertEqual(line, ChartIQDrawingTool.line.stringValue)
    XCTAssertEqual(measurementLine, ChartIQDrawingTool.measurementLine.stringValue)
    XCTAssertEqual(pitchfork, ChartIQDrawingTool.pitchfork.stringValue)
    XCTAssertEqual(quadrantLines, ChartIQDrawingTool.quadrantLines.stringValue)
    XCTAssertEqual(ray, ChartIQDrawingTool.ray.stringValue)
    XCTAssertEqual(rectangle, ChartIQDrawingTool.rectangle.stringValue)
    XCTAssertEqual(regression, ChartIQDrawingTool.regression.stringValue)
    XCTAssertEqual(speedResistanceArc, ChartIQDrawingTool.speedResistanceArc.stringValue)
    XCTAssertEqual(speedResistanceLine, ChartIQDrawingTool.speedResistanceLine.stringValue)
    XCTAssertEqual(timeCycle, ChartIQDrawingTool.timeCycle.stringValue)
    XCTAssertEqual(tironeLevels, ChartIQDrawingTool.tironeLevels.stringValue)
    XCTAssertEqual(trend, ChartIQDrawingTool.trendLine.stringValue)
    XCTAssertEqual(vertical, ChartIQDrawingTool.vertical.stringValue)
    XCTAssertEqual(volumeProfile, ChartIQDrawingTool.volumeProfile.stringValue)
    XCTAssertEqual(measure, ChartIQDrawingTool.measure.stringValue)
  }

  func testsChartIQDrawingToolEnumGetDisplayNameValue() {
    // Given
    let annotation = "Annotation"
    let arrow = "Arrow"
    let average = "Average Line"
    let callout = "Callout"
    let channel = "Channel"
    let continuous = "Continuous"
    let crossline = "Crossline"
    let doodle = "Doodle"
    let elliottWave = "Elliott Wave"
    let ellipse = "Ellipse"
    let fibArc = "Fib Arc"
    let fibFan = "Fib Fan"
    let fibProjection = "Fib Projection"
    let fibRetracement = "Fib Retracement"
    let fibTimeZone = "Fib Time Zone"
    let gannFan = "Gann Fan"
    let gartley = "Gartley"
    let horizontal = "Horizontal"
    let line = "Line"
    let measurementLine = "Measurement Line"
    let pitchfork = "Pitchfork"
    let quadrantLines = "Quadrant Lines"
    let ray = "Ray"
    let rectangle = "Rectangle"
    let regression = "Regression Line"
    let speedResistanceArc = "Speed Resistance Arc"
    let speedResistanceLine = "Speed Resistance Line"
    let timeCycle = "Time Cycle"
    let tironeLevels = "Tirone Levels"
    let trend = "Trend Line"
    let vertical = "Vertical"
    let volumeProfile = "Volume Profile"
    let measure = "Measure"

    // When // Then
    XCTAssertEqual(annotation, ChartIQDrawingTool.annotation.displayName)
    XCTAssertEqual(arrow, ChartIQDrawingTool.arrow.displayName)
    XCTAssertEqual(average, ChartIQDrawingTool.average.displayName)
    XCTAssertEqual(callout, ChartIQDrawingTool.callout.displayName)
    XCTAssertEqual(channel, ChartIQDrawingTool.channel.displayName)
    XCTAssertEqual(continuous, ChartIQDrawingTool.continuous.displayName)
    XCTAssertEqual(crossline, ChartIQDrawingTool.crossline.displayName)
    XCTAssertEqual(doodle, ChartIQDrawingTool.doodle.displayName)
    XCTAssertEqual(elliottWave, ChartIQDrawingTool.elliottWave.displayName)
    XCTAssertEqual(ellipse, ChartIQDrawingTool.ellipse.displayName)
    XCTAssertEqual(fibArc, ChartIQDrawingTool.fibArc.displayName)
    XCTAssertEqual(fibFan, ChartIQDrawingTool.fibFan.displayName)
    XCTAssertEqual(fibProjection, ChartIQDrawingTool.fibProjection.displayName)
    XCTAssertEqual(fibRetracement, ChartIQDrawingTool.fibRetracement.displayName)
    XCTAssertEqual(fibTimeZone, ChartIQDrawingTool.fibTimeZone.displayName)
    XCTAssertEqual(gannFan, ChartIQDrawingTool.gannFan.displayName)
    XCTAssertEqual(gartley, ChartIQDrawingTool.gartley.displayName)
    XCTAssertEqual(horizontal, ChartIQDrawingTool.horizontal.displayName)
    XCTAssertEqual(line, ChartIQDrawingTool.line.displayName)
    XCTAssertEqual(measurementLine, ChartIQDrawingTool.measurementLine.displayName)
    XCTAssertEqual(pitchfork, ChartIQDrawingTool.pitchfork.displayName)
    XCTAssertEqual(quadrantLines, ChartIQDrawingTool.quadrantLines.displayName)
    XCTAssertEqual(ray, ChartIQDrawingTool.ray.displayName)
    XCTAssertEqual(rectangle, ChartIQDrawingTool.rectangle.displayName)
    XCTAssertEqual(regression, ChartIQDrawingTool.regression.displayName)
    XCTAssertEqual(speedResistanceArc, ChartIQDrawingTool.speedResistanceArc.displayName)
    XCTAssertEqual(speedResistanceLine, ChartIQDrawingTool.speedResistanceLine.displayName)
    XCTAssertEqual(timeCycle, ChartIQDrawingTool.timeCycle.displayName)
    XCTAssertEqual(tironeLevels, ChartIQDrawingTool.tironeLevels.displayName)
    XCTAssertEqual(trend, ChartIQDrawingTool.trendLine.displayName)
    XCTAssertEqual(vertical, ChartIQDrawingTool.vertical.displayName)
    XCTAssertEqual(volumeProfile, ChartIQDrawingTool.volumeProfile.displayName)
    XCTAssertEqual(measure, ChartIQDrawingTool.measure.displayName)
  }

  func testsChartIQDrawingToolEnumGetTypeValue() {
    // Given
    let annotation: ChartIQDrawingToolType = .text
    let arrow: ChartIQDrawingToolType = .markings
    let average: ChartIQDrawingToolType = .statistics
    let callout: ChartIQDrawingToolType = .text
    let channel: ChartIQDrawingToolType = .lines
    let continuous: ChartIQDrawingToolType = .lines
    let crossline: ChartIQDrawingToolType = .lines
    let doodle: ChartIQDrawingToolType = .lines
    let elliottWave: ChartIQDrawingToolType = .technicals
    let ellipse: ChartIQDrawingToolType = .markings
    let fibArc: ChartIQDrawingToolType = .fibonacci
    let fibFan: ChartIQDrawingToolType = .fibonacci
    let fibProjection: ChartIQDrawingToolType = .fibonacci
    let fibRetracement: ChartIQDrawingToolType = .fibonacci
    let fibTimeZone: ChartIQDrawingToolType = .fibonacci
    let gannFan: ChartIQDrawingToolType = .technicals
    let gartley: ChartIQDrawingToolType = .technicals
    let horizontal: ChartIQDrawingToolType = .lines
    let line: ChartIQDrawingToolType = .lines
    let measurementLine: ChartIQDrawingToolType = .statistics
    let pitchfork: ChartIQDrawingToolType = .technicals
    let quadrantLines: ChartIQDrawingToolType = .statistics
    let ray: ChartIQDrawingToolType = .lines
    let rectangle: ChartIQDrawingToolType = .markings
    let regression: ChartIQDrawingToolType = .statistics
    let speedResistanceArc: ChartIQDrawingToolType = .technicals
    let speedResistanceLine: ChartIQDrawingToolType = .technicals
    let timeCycle: ChartIQDrawingToolType = .technicals
    let tironeLevels: ChartIQDrawingToolType = .statistics
    let trend: ChartIQDrawingToolType = .lines
    let vertical: ChartIQDrawingToolType = .lines
    let volumeProfile: ChartIQDrawingToolType = .statistics
    let measure: ChartIQDrawingToolType = .text

    // When // Then
    XCTAssertEqual(annotation, ChartIQDrawingTool.annotation.type)
    XCTAssertEqual(arrow, ChartIQDrawingTool.arrow.type)
    XCTAssertEqual(average, ChartIQDrawingTool.average.type)
    XCTAssertEqual(callout, ChartIQDrawingTool.callout.type)
    XCTAssertEqual(channel, ChartIQDrawingTool.channel.type)
    XCTAssertEqual(continuous, ChartIQDrawingTool.continuous.type)
    XCTAssertEqual(crossline, ChartIQDrawingTool.crossline.type)
    XCTAssertEqual(doodle, ChartIQDrawingTool.doodle.type)
    XCTAssertEqual(elliottWave, ChartIQDrawingTool.elliottWave.type)
    XCTAssertEqual(ellipse, ChartIQDrawingTool.ellipse.type)
    XCTAssertEqual(fibArc, ChartIQDrawingTool.fibArc.type)
    XCTAssertEqual(fibFan, ChartIQDrawingTool.fibFan.type)
    XCTAssertEqual(fibProjection, ChartIQDrawingTool.fibProjection.type)
    XCTAssertEqual(fibRetracement, ChartIQDrawingTool.fibRetracement.type)
    XCTAssertEqual(fibTimeZone, ChartIQDrawingTool.fibTimeZone.type)
    XCTAssertEqual(gannFan, ChartIQDrawingTool.gannFan.type)
    XCTAssertEqual(gartley, ChartIQDrawingTool.gartley.type)
    XCTAssertEqual(horizontal, ChartIQDrawingTool.horizontal.type)
    XCTAssertEqual(line, ChartIQDrawingTool.line.type)
    XCTAssertEqual(measurementLine, ChartIQDrawingTool.measurementLine.type)
    XCTAssertEqual(pitchfork, ChartIQDrawingTool.pitchfork.type)
    XCTAssertEqual(quadrantLines, ChartIQDrawingTool.quadrantLines.type)
    XCTAssertEqual(ray, ChartIQDrawingTool.ray.type)
    XCTAssertEqual(rectangle, ChartIQDrawingTool.rectangle.type)
    XCTAssertEqual(regression, ChartIQDrawingTool.regression.type)
    XCTAssertEqual(speedResistanceArc, ChartIQDrawingTool.speedResistanceArc.type)
    XCTAssertEqual(speedResistanceLine, ChartIQDrawingTool.speedResistanceLine.type)
    XCTAssertEqual(timeCycle, ChartIQDrawingTool.timeCycle.type)
    XCTAssertEqual(tironeLevels, ChartIQDrawingTool.tironeLevels.type)
    XCTAssertEqual(trend, ChartIQDrawingTool.trendLine.type)
    XCTAssertEqual(vertical, ChartIQDrawingTool.vertical.type)
    XCTAssertEqual(volumeProfile, ChartIQDrawingTool.volumeProfile.type)
    XCTAssertEqual(measure, ChartIQDrawingTool.measure.type)
  }

  func testsChartIQDrawingToolEnumInitWithStringValue() {
    // Given
    let annotation = "annotation"
    let arrow = "arrowline"
    let average = "average"
    let callout = "callout"
    let channel = "channel"
    let continuous = "continuous"
    let crossline = "crossline"
    let doodle = "freeform"
    let elliottWave = "elliottwave"
    let ellipse = "ellipse"
    let fibArc = "fibarc"
    let fibFan = "fibfan"
    let fibProjection = "fibprojection"
    let fibRetracement = "retracement"
    let fibTimeZone = "fibtimezone"
    let gannFan = "gannfan"
    let gartley = "gartley"
    let horizontal = "horizontal"
    let line = "line"
    let measurementLine = "measurementline"
    let pitchfork = "pitchfork"
    let quadrantLines = "quadrant"
    let ray = "ray"
    let rectangle = "rectangle"
    let regression = "regression"
    let speedResistanceArc = "speedarc"
    let speedResistanceLine = "speedline"
    let timeCycle = "timecycle"
    let tironeLevels = "tirone"
    let trend = "trendline"
    let vertical = "vertical"
    let measure = "measure"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQDrawingTool.annotation, ChartIQDrawingTool(stringValue: annotation))
    XCTAssertEqual(ChartIQDrawingTool.arrow, ChartIQDrawingTool(stringValue: arrow))
    XCTAssertEqual(ChartIQDrawingTool.average, ChartIQDrawingTool(stringValue: average))
    XCTAssertEqual(ChartIQDrawingTool.callout, ChartIQDrawingTool(stringValue: callout))
    XCTAssertEqual(ChartIQDrawingTool.channel, ChartIQDrawingTool(stringValue: channel))
    XCTAssertEqual(ChartIQDrawingTool.continuous, ChartIQDrawingTool(stringValue: continuous))
    XCTAssertEqual(ChartIQDrawingTool.crossline, ChartIQDrawingTool(stringValue: crossline))
    XCTAssertEqual(ChartIQDrawingTool.doodle, ChartIQDrawingTool(stringValue: doodle))
    XCTAssertEqual(ChartIQDrawingTool.elliottWave, ChartIQDrawingTool(stringValue: elliottWave))
    XCTAssertEqual(ChartIQDrawingTool.ellipse, ChartIQDrawingTool(stringValue: ellipse))
    XCTAssertEqual(ChartIQDrawingTool.fibArc, ChartIQDrawingTool(stringValue: fibArc))
    XCTAssertEqual(ChartIQDrawingTool.fibFan, ChartIQDrawingTool(stringValue: fibFan))
    XCTAssertEqual(ChartIQDrawingTool.fibProjection, ChartIQDrawingTool(stringValue: fibProjection))
    XCTAssertEqual(ChartIQDrawingTool.fibRetracement, ChartIQDrawingTool(stringValue: fibRetracement))
    XCTAssertEqual(ChartIQDrawingTool.fibTimeZone, ChartIQDrawingTool(stringValue: fibTimeZone))
    XCTAssertEqual(ChartIQDrawingTool.gannFan, ChartIQDrawingTool(stringValue: gannFan))
    XCTAssertEqual(ChartIQDrawingTool.gartley, ChartIQDrawingTool(stringValue: gartley))
    XCTAssertEqual(ChartIQDrawingTool.horizontal, ChartIQDrawingTool(stringValue: horizontal))
    XCTAssertEqual(ChartIQDrawingTool.line, ChartIQDrawingTool(stringValue: line))
    XCTAssertEqual(ChartIQDrawingTool.measurementLine, ChartIQDrawingTool(stringValue: measurementLine))
    XCTAssertEqual(ChartIQDrawingTool.pitchfork, ChartIQDrawingTool(stringValue: pitchfork))
    XCTAssertEqual(ChartIQDrawingTool.quadrantLines, ChartIQDrawingTool(stringValue: quadrantLines))
    XCTAssertEqual(ChartIQDrawingTool.ray, ChartIQDrawingTool(stringValue: ray))
    XCTAssertEqual(ChartIQDrawingTool.rectangle, ChartIQDrawingTool(stringValue: rectangle))
    XCTAssertEqual(ChartIQDrawingTool.regression, ChartIQDrawingTool(stringValue: regression))
    XCTAssertEqual(ChartIQDrawingTool.speedResistanceArc, ChartIQDrawingTool(stringValue: speedResistanceArc))
    XCTAssertEqual(ChartIQDrawingTool.speedResistanceLine, ChartIQDrawingTool(stringValue: speedResistanceLine))
    XCTAssertEqual(ChartIQDrawingTool.timeCycle, ChartIQDrawingTool(stringValue: timeCycle))
    XCTAssertEqual(ChartIQDrawingTool.tironeLevels, ChartIQDrawingTool(stringValue: tironeLevels))
    XCTAssertEqual(ChartIQDrawingTool.trendLine, ChartIQDrawingTool(stringValue: trend))
    XCTAssertEqual(ChartIQDrawingTool.vertical, ChartIQDrawingTool(stringValue: vertical))
    XCTAssertEqual(ChartIQDrawingTool.measure, ChartIQDrawingTool(stringValue: measure))

    XCTAssertNil(ChartIQDrawingTool(stringValue: invalidString))
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

  // MARK: - ChartIQDrawingParameterType

  func testsChartIQDrawingParameterTypeEnumGetStringValue() {
    // Given
    let fillColor = "fillColor"
    let lineColor = "color"
    let pattern = "pattern"
    let lineWidth = "lineWidth"
    let family = "family"
    let size = "size"
    let style = "style"
    let weight = "weight"
    let fibs = "fibs"
    let axisLabel = "axisLabel"
    let showLines = "showLines"
    let showCallout = "showCallout"
    let waveTemplate = "waveTemplate"
    let impulse = "impulse"
    let corrective = "corrective"
    let decoration = "decoration"
    let active1 = "active1"
    let active2 = "active2"
    let active3 = "active3"
    let color1 = "color1"
    let color2 = "color2"
    let color3 = "color3"
    let lineWidth1 = "lineWidth1"
    let lineWidth2 = "lineWidth2"
    let lineWidth3 = "lineWidth3"
    let pattern1 = "pattern1"
    let pattern2 = "pattern2"
    let pattern3 = "pattern3"
    let priceBuckets = "priceBuckets"

    // When // Then
    XCTAssertEqual(fillColor, ChartIQDrawingParameterType.fillColor.stringValue)
    XCTAssertEqual(lineColor, ChartIQDrawingParameterType.lineColor.stringValue)
    XCTAssertEqual(pattern, ChartIQDrawingParameterType.pattern.stringValue)
    XCTAssertEqual(lineWidth, ChartIQDrawingParameterType.lineWidth.stringValue)
    XCTAssertEqual(family, ChartIQDrawingParameterType.family.stringValue)
    XCTAssertEqual(size, ChartIQDrawingParameterType.size.stringValue)
    XCTAssertEqual(style, ChartIQDrawingParameterType.style.stringValue)
    XCTAssertEqual(weight, ChartIQDrawingParameterType.weight.stringValue)
    XCTAssertEqual(fibs, ChartIQDrawingParameterType.fibs.stringValue)
    XCTAssertEqual(axisLabel, ChartIQDrawingParameterType.axisLabel.stringValue)
    XCTAssertEqual(showLines, ChartIQDrawingParameterType.showLines.stringValue)
    XCTAssertEqual(showCallout, ChartIQDrawingParameterType.showCallout.stringValue)
    XCTAssertEqual(waveTemplate, ChartIQDrawingParameterType.waveTemplate.stringValue)
    XCTAssertEqual(impulse, ChartIQDrawingParameterType.impulse.stringValue)
    XCTAssertEqual(corrective, ChartIQDrawingParameterType.corrective.stringValue)
    XCTAssertEqual(decoration, ChartIQDrawingParameterType.decoration.stringValue)
    XCTAssertEqual(active1, ChartIQDrawingParameterType.active1.stringValue)
    XCTAssertEqual(active2, ChartIQDrawingParameterType.active2.stringValue)
    XCTAssertEqual(active3, ChartIQDrawingParameterType.active3.stringValue)
    XCTAssertEqual(color1, ChartIQDrawingParameterType.color1.stringValue)
    XCTAssertEqual(color2, ChartIQDrawingParameterType.color2.stringValue)
    XCTAssertEqual(color3, ChartIQDrawingParameterType.color3.stringValue)
    XCTAssertEqual(lineWidth1, ChartIQDrawingParameterType.lineWidth1.stringValue)
    XCTAssertEqual(lineWidth2, ChartIQDrawingParameterType.lineWidth2.stringValue)
    XCTAssertEqual(lineWidth3, ChartIQDrawingParameterType.lineWidth3.stringValue)
    XCTAssertEqual(pattern1, ChartIQDrawingParameterType.pattern1.stringValue)
    XCTAssertEqual(pattern2, ChartIQDrawingParameterType.pattern2.stringValue)
    XCTAssertEqual(pattern3, ChartIQDrawingParameterType.pattern3.stringValue)
    XCTAssertEqual(priceBuckets, ChartIQDrawingParameterType.priceBuckets.stringValue)
  }
}
