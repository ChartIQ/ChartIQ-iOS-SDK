//
//  ChartIQDrawingToolTests.swift
//  ChartIQTests
//
//  Copyright 2012-2020 by ChartIQ, Inc.
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
    let arrow = "arrow"
    let average = "average"
    let callout = "callout"
    let channel = "channel"
    let check = "check"
    let continuous = "continuous"
    let cross = "xcross"
    let crossline = "crossline"
    let doodle = "freeform"
    let elliottWave = "elliottwave"
    let ellipse = "ellipse"
    let fibArc = "fibarc"
    let fibFan = "fibfan"
    let fibProjection = "fibprojection"
    let fibRetracement = "fibonacci"
    let fibTimeZone = "fibtimezone"
    let focus = "focusarrow"
    let gannFan = "gannfan"
    let gartley = "gartley"
    let heart = "heart"
    let horizontal = "horizontal"
    let line = "line"
    let pitchfork = "pitchfork"
    let quadrantLines = "quadrant"
    let ray = "ray"
    let rectangle = "rectangle"
    let regression = "regression"
    let segment = "segment"
    let speedResistanceArc = "speedarc"
    let speedResistanceLine = "speedline"
    let star = "star"
    let timeCycle = "timecycle"
    let tironeLevels = "tirone"
    let trend = "trendline"
    let vertical = "vertical"
    let noTool = "notool"
    let measure = "measure"

    // When // Then
    XCTAssertEqual(annotation, ChartIQDrawingTool.annotation.stringValue)
    XCTAssertEqual(arrow, ChartIQDrawingTool.arrow.stringValue)
    XCTAssertEqual(average, ChartIQDrawingTool.average.stringValue)
    XCTAssertEqual(callout, ChartIQDrawingTool.callout.stringValue)
    XCTAssertEqual(channel, ChartIQDrawingTool.channel.stringValue)
    XCTAssertEqual(check, ChartIQDrawingTool.check.stringValue)
    XCTAssertEqual(continuous, ChartIQDrawingTool.continuous.stringValue)
    XCTAssertEqual(cross, ChartIQDrawingTool.cross.stringValue)
    XCTAssertEqual(crossline, ChartIQDrawingTool.crossline.stringValue)
    XCTAssertEqual(doodle, ChartIQDrawingTool.doodle.stringValue)
    XCTAssertEqual(elliottWave, ChartIQDrawingTool.elliottWave.stringValue)
    XCTAssertEqual(ellipse, ChartIQDrawingTool.ellipse.stringValue)
    XCTAssertEqual(fibArc, ChartIQDrawingTool.fibArc.stringValue)
    XCTAssertEqual(fibFan, ChartIQDrawingTool.fibFan.stringValue)
    XCTAssertEqual(fibProjection, ChartIQDrawingTool.fibProjection.stringValue)
    XCTAssertEqual(fibRetracement, ChartIQDrawingTool.fibRetracement.stringValue)
    XCTAssertEqual(fibTimeZone, ChartIQDrawingTool.fibTimeZone.stringValue)
    XCTAssertEqual(focus, ChartIQDrawingTool.focus.stringValue)
    XCTAssertEqual(gannFan, ChartIQDrawingTool.gannFan.stringValue)
    XCTAssertEqual(gartley, ChartIQDrawingTool.gartley.stringValue)
    XCTAssertEqual(heart, ChartIQDrawingTool.heart.stringValue)
    XCTAssertEqual(horizontal, ChartIQDrawingTool.horizontal.stringValue)
    XCTAssertEqual(line, ChartIQDrawingTool.line.stringValue)
    XCTAssertEqual(pitchfork, ChartIQDrawingTool.pitchfork.stringValue)
    XCTAssertEqual(quadrantLines, ChartIQDrawingTool.quadrantLines.stringValue)
    XCTAssertEqual(ray, ChartIQDrawingTool.ray.stringValue)
    XCTAssertEqual(rectangle, ChartIQDrawingTool.rectangle.stringValue)
    XCTAssertEqual(regression, ChartIQDrawingTool.regression.stringValue)
    XCTAssertEqual(segment, ChartIQDrawingTool.segment.stringValue)
    XCTAssertEqual(speedResistanceArc, ChartIQDrawingTool.speedResistanceArc.stringValue)
    XCTAssertEqual(speedResistanceLine, ChartIQDrawingTool.speedResistanceLine.stringValue)
    XCTAssertEqual(star, ChartIQDrawingTool.star.stringValue)
    XCTAssertEqual(timeCycle, ChartIQDrawingTool.timeCycle.stringValue)
    XCTAssertEqual(tironeLevels, ChartIQDrawingTool.tironeLevels.stringValue)
    XCTAssertEqual(trend, ChartIQDrawingTool.trend.stringValue)
    XCTAssertEqual(vertical, ChartIQDrawingTool.vertical.stringValue)
    XCTAssertEqual(noTool, ChartIQDrawingTool.noTool.stringValue)
    XCTAssertEqual(measure, ChartIQDrawingTool.measure.stringValue)
  }

  func testsChartIQDrawingToolEnumGetDisplayNameValue() {
    // Given
    let annotation = "Annotation"
    let arrow = "Arrow"
    let average = "Average Line"
    let callout = "Callout"
    let channel = "Channel"
    let check = "Check"
    let continuous = "Continuous"
    let cross = "Cross"
    let crossline = "Crossline"
    let doodle = "Doodle"
    let elliottWave = "Elliott Wave"
    let ellipse = "Ellipse"
    let fibArc = "Fib Arc"
    let fibFan = "Fib Fan"
    let fibProjection = "Fib Projection"
    let fibRetracement = "Fib Retracement"
    let fibTimeZone = "Fib Time Zone"
    let focus = "Focus"
    let gannFan = "Gann Fan"
    let gartley = "Gartley"
    let heart = "Heart"
    let horizontal = "Horizontal"
    let line = "Line"
    let pitchfork = "Pitchfork"
    let quadrantLines = "Quadrant Lines"
    let ray = "Ray"
    let rectangle = "Rectangle"
    let regression = "Regression Line"
    let segment = "Segment"
    let speedResistanceArc = "Speed Resistance Arc"
    let speedResistanceLine = "Speed Resistance Line"
    let star = "Star"
    let timeCycle = "Time Cycle"
    let tironeLevels = "Tirone Levels"
    let trend = "Trend Line"
    let vertical = "Vertical"
    let noTool = "No Tool"
    let measure = "Measure"

    // When // Then
    XCTAssertEqual(annotation, ChartIQDrawingTool.annotation.displayName)
    XCTAssertEqual(arrow, ChartIQDrawingTool.arrow.displayName)
    XCTAssertEqual(average, ChartIQDrawingTool.average.displayName)
    XCTAssertEqual(callout, ChartIQDrawingTool.callout.displayName)
    XCTAssertEqual(channel, ChartIQDrawingTool.channel.displayName)
    XCTAssertEqual(check, ChartIQDrawingTool.check.displayName)
    XCTAssertEqual(continuous, ChartIQDrawingTool.continuous.displayName)
    XCTAssertEqual(cross, ChartIQDrawingTool.cross.displayName)
    XCTAssertEqual(crossline, ChartIQDrawingTool.crossline.displayName)
    XCTAssertEqual(doodle, ChartIQDrawingTool.doodle.displayName)
    XCTAssertEqual(elliottWave, ChartIQDrawingTool.elliottWave.displayName)
    XCTAssertEqual(ellipse, ChartIQDrawingTool.ellipse.displayName)
    XCTAssertEqual(fibArc, ChartIQDrawingTool.fibArc.displayName)
    XCTAssertEqual(fibFan, ChartIQDrawingTool.fibFan.displayName)
    XCTAssertEqual(fibProjection, ChartIQDrawingTool.fibProjection.displayName)
    XCTAssertEqual(fibRetracement, ChartIQDrawingTool.fibRetracement.displayName)
    XCTAssertEqual(fibTimeZone, ChartIQDrawingTool.fibTimeZone.displayName)
    XCTAssertEqual(focus, ChartIQDrawingTool.focus.displayName)
    XCTAssertEqual(gannFan, ChartIQDrawingTool.gannFan.displayName)
    XCTAssertEqual(gartley, ChartIQDrawingTool.gartley.displayName)
    XCTAssertEqual(heart, ChartIQDrawingTool.heart.displayName)
    XCTAssertEqual(horizontal, ChartIQDrawingTool.horizontal.displayName)
    XCTAssertEqual(line, ChartIQDrawingTool.line.displayName)
    XCTAssertEqual(pitchfork, ChartIQDrawingTool.pitchfork.displayName)
    XCTAssertEqual(quadrantLines, ChartIQDrawingTool.quadrantLines.displayName)
    XCTAssertEqual(ray, ChartIQDrawingTool.ray.displayName)
    XCTAssertEqual(rectangle, ChartIQDrawingTool.rectangle.displayName)
    XCTAssertEqual(regression, ChartIQDrawingTool.regression.displayName)
    XCTAssertEqual(segment, ChartIQDrawingTool.segment.displayName)
    XCTAssertEqual(speedResistanceArc, ChartIQDrawingTool.speedResistanceArc.displayName)
    XCTAssertEqual(speedResistanceLine, ChartIQDrawingTool.speedResistanceLine.displayName)
    XCTAssertEqual(star, ChartIQDrawingTool.star.displayName)
    XCTAssertEqual(timeCycle, ChartIQDrawingTool.timeCycle.displayName)
    XCTAssertEqual(tironeLevels, ChartIQDrawingTool.tironeLevels.displayName)
    XCTAssertEqual(trend, ChartIQDrawingTool.trend.displayName)
    XCTAssertEqual(vertical, ChartIQDrawingTool.vertical.displayName)
    XCTAssertEqual(noTool, ChartIQDrawingTool.noTool.displayName)
    XCTAssertEqual(measure, ChartIQDrawingTool.measure.displayName)
  }

  func testsChartIQDrawingToolEnumGetTypeValue() {
    // Given
    let annotation: ChartIQDrawingToolType = .text
    let arrow: ChartIQDrawingToolType = .markings
    let average: ChartIQDrawingToolType = .statistics
    let callout: ChartIQDrawingToolType = .text
    let channel: ChartIQDrawingToolType = .lines
    let check: ChartIQDrawingToolType = .markings
    let continuous: ChartIQDrawingToolType = .lines
    let cross: ChartIQDrawingToolType = .markings
    let crossline: ChartIQDrawingToolType = .lines
    let doodle: ChartIQDrawingToolType = .lines
    let elliottWave: ChartIQDrawingToolType = .technicals
    let ellipse: ChartIQDrawingToolType = .markings
    let fibArc: ChartIQDrawingToolType = .fibonacci
    let fibFan: ChartIQDrawingToolType = .fibonacci
    let fibProjection: ChartIQDrawingToolType = .fibonacci
    let fibRetracement: ChartIQDrawingToolType = .fibonacci
    let fibTimeZone: ChartIQDrawingToolType = .fibonacci
    let focus: ChartIQDrawingToolType = .markings
    let gannFan: ChartIQDrawingToolType = .technicals
    let gartley: ChartIQDrawingToolType = .technicals
    let heart: ChartIQDrawingToolType = .markings
    let horizontal: ChartIQDrawingToolType = .lines
    let line: ChartIQDrawingToolType = .lines
    let pitchfork: ChartIQDrawingToolType = .technicals
    let quadrantLines: ChartIQDrawingToolType = .statistics
    let ray: ChartIQDrawingToolType = .lines
    let rectangle: ChartIQDrawingToolType = .markings
    let regression: ChartIQDrawingToolType = .statistics
    let segment: ChartIQDrawingToolType = .lines
    let speedResistanceArc: ChartIQDrawingToolType = .technicals
    let speedResistanceLine: ChartIQDrawingToolType = .technicals
    let star: ChartIQDrawingToolType = .markings
    let timeCycle: ChartIQDrawingToolType = .technicals
    let tironeLevels: ChartIQDrawingToolType = .statistics
    let trend: ChartIQDrawingToolType = .text
    let vertical: ChartIQDrawingToolType = .lines
    let noTool: ChartIQDrawingToolType = .text
    let measure: ChartIQDrawingToolType = .text

    // When // Then
    XCTAssertEqual(annotation, ChartIQDrawingTool.annotation.type)
    XCTAssertEqual(arrow, ChartIQDrawingTool.arrow.type)
    XCTAssertEqual(average, ChartIQDrawingTool.average.type)
    XCTAssertEqual(callout, ChartIQDrawingTool.callout.type)
    XCTAssertEqual(channel, ChartIQDrawingTool.channel.type)
    XCTAssertEqual(check, ChartIQDrawingTool.check.type)
    XCTAssertEqual(continuous, ChartIQDrawingTool.continuous.type)
    XCTAssertEqual(cross, ChartIQDrawingTool.cross.type)
    XCTAssertEqual(crossline, ChartIQDrawingTool.crossline.type)
    XCTAssertEqual(doodle, ChartIQDrawingTool.doodle.type)
    XCTAssertEqual(elliottWave, ChartIQDrawingTool.elliottWave.type)
    XCTAssertEqual(ellipse, ChartIQDrawingTool.ellipse.type)
    XCTAssertEqual(fibArc, ChartIQDrawingTool.fibArc.type)
    XCTAssertEqual(fibFan, ChartIQDrawingTool.fibFan.type)
    XCTAssertEqual(fibProjection, ChartIQDrawingTool.fibProjection.type)
    XCTAssertEqual(fibRetracement, ChartIQDrawingTool.fibRetracement.type)
    XCTAssertEqual(fibTimeZone, ChartIQDrawingTool.fibTimeZone.type)
    XCTAssertEqual(focus, ChartIQDrawingTool.focus.type)
    XCTAssertEqual(gannFan, ChartIQDrawingTool.gannFan.type)
    XCTAssertEqual(gartley, ChartIQDrawingTool.gartley.type)
    XCTAssertEqual(heart, ChartIQDrawingTool.heart.type)
    XCTAssertEqual(horizontal, ChartIQDrawingTool.horizontal.type)
    XCTAssertEqual(line, ChartIQDrawingTool.line.type)
    XCTAssertEqual(pitchfork, ChartIQDrawingTool.pitchfork.type)
    XCTAssertEqual(quadrantLines, ChartIQDrawingTool.quadrantLines.type)
    XCTAssertEqual(ray, ChartIQDrawingTool.ray.type)
    XCTAssertEqual(rectangle, ChartIQDrawingTool.rectangle.type)
    XCTAssertEqual(regression, ChartIQDrawingTool.regression.type)
    XCTAssertEqual(segment, ChartIQDrawingTool.segment.type)
    XCTAssertEqual(speedResistanceArc, ChartIQDrawingTool.speedResistanceArc.type)
    XCTAssertEqual(speedResistanceLine, ChartIQDrawingTool.speedResistanceLine.type)
    XCTAssertEqual(star, ChartIQDrawingTool.star.type)
    XCTAssertEqual(timeCycle, ChartIQDrawingTool.timeCycle.type)
    XCTAssertEqual(tironeLevels, ChartIQDrawingTool.tironeLevels.type)
    XCTAssertEqual(trend, ChartIQDrawingTool.trend.type)
    XCTAssertEqual(vertical, ChartIQDrawingTool.vertical.type)
    XCTAssertEqual(noTool, ChartIQDrawingTool.noTool.type)
    XCTAssertEqual(measure, ChartIQDrawingTool.measure.type)
  }

  // MARK: - Tests ChartIQLineType Enum

  func testsChartIQDrawingToolEnumInitWithStringValue() {
    // Given
    let annotation = "annotation"
    let arrow = "arrow"
    let average = "average"
    let callout = "callout"
    let channel = "channel"
    let check = "check"
    let continuous = "continuous"
    let cross = "xcross"
    let crossline = "crossline"
    let doodle = "freeform"
    let elliottWave = "elliottwave"
    let ellipse = "ellipse"
    let fibArc = "fibarc"
    let fibFan = "fibfan"
    let fibProjection = "fibprojection"
    let fibRetracement = "fibonacci"
    let fibTimeZone = "fibtimezone"
    let focus = "focusarrow"
    let gannFan = "gannfan"
    let gartley = "gartley"
    let heart = "heart"
    let horizontal = "horizontal"
    let line = "line"
    let pitchfork = "pitchfork"
    let quadrantLines = "quadrant"
    let ray = "ray"
    let rectangle = "rectangle"
    let regression = "regression"
    let segment = "segment"
    let speedResistanceArc = "speedarc"
    let speedResistanceLine = "speedline"
    let star = "star"
    let timeCycle = "timecycle"
    let tironeLevels = "tirone"
    let trend = "trendline"
    let vertical = "vertical"
    let noTool = "notool"
    let measure = "measure"

    let invalidString = "invalid string"

    // When // Then
    XCTAssertEqual(ChartIQDrawingTool.annotation, ChartIQDrawingTool(stringValue: annotation))
    XCTAssertEqual(ChartIQDrawingTool.arrow, ChartIQDrawingTool(stringValue: arrow))
    XCTAssertEqual(ChartIQDrawingTool.average, ChartIQDrawingTool(stringValue: average))
    XCTAssertEqual(ChartIQDrawingTool.callout, ChartIQDrawingTool(stringValue: callout))
    XCTAssertEqual(ChartIQDrawingTool.channel, ChartIQDrawingTool(stringValue: channel))
    XCTAssertEqual(ChartIQDrawingTool.check, ChartIQDrawingTool(stringValue: check))
    XCTAssertEqual(ChartIQDrawingTool.continuous, ChartIQDrawingTool(stringValue: continuous))
    XCTAssertEqual(ChartIQDrawingTool.cross, ChartIQDrawingTool(stringValue: cross))
    XCTAssertEqual(ChartIQDrawingTool.crossline, ChartIQDrawingTool(stringValue: crossline))
    XCTAssertEqual(ChartIQDrawingTool.doodle, ChartIQDrawingTool(stringValue: doodle))
    XCTAssertEqual(ChartIQDrawingTool.elliottWave, ChartIQDrawingTool(stringValue: elliottWave))
    XCTAssertEqual(ChartIQDrawingTool.ellipse, ChartIQDrawingTool(stringValue: ellipse))
    XCTAssertEqual(ChartIQDrawingTool.fibArc, ChartIQDrawingTool(stringValue: fibArc))
    XCTAssertEqual(ChartIQDrawingTool.fibFan, ChartIQDrawingTool(stringValue: fibFan))
    XCTAssertEqual(ChartIQDrawingTool.fibProjection, ChartIQDrawingTool(stringValue: fibProjection))
    XCTAssertEqual(ChartIQDrawingTool.fibRetracement, ChartIQDrawingTool(stringValue: fibRetracement))
    XCTAssertEqual(ChartIQDrawingTool.fibTimeZone, ChartIQDrawingTool(stringValue: fibTimeZone))
    XCTAssertEqual(ChartIQDrawingTool.focus, ChartIQDrawingTool(stringValue: focus))
    XCTAssertEqual(ChartIQDrawingTool.gannFan, ChartIQDrawingTool(stringValue: gannFan))
    XCTAssertEqual(ChartIQDrawingTool.gartley, ChartIQDrawingTool(stringValue: gartley))
    XCTAssertEqual(ChartIQDrawingTool.heart, ChartIQDrawingTool(stringValue: heart))
    XCTAssertEqual(ChartIQDrawingTool.horizontal, ChartIQDrawingTool(stringValue: horizontal))
    XCTAssertEqual(ChartIQDrawingTool.line, ChartIQDrawingTool(stringValue: line))
    XCTAssertEqual(ChartIQDrawingTool.pitchfork, ChartIQDrawingTool(stringValue: pitchfork))
    XCTAssertEqual(ChartIQDrawingTool.quadrantLines, ChartIQDrawingTool(stringValue: quadrantLines))
    XCTAssertEqual(ChartIQDrawingTool.ray, ChartIQDrawingTool(stringValue: ray))
    XCTAssertEqual(ChartIQDrawingTool.rectangle, ChartIQDrawingTool(stringValue: rectangle))
    XCTAssertEqual(ChartIQDrawingTool.regression, ChartIQDrawingTool(stringValue: regression))
    XCTAssertEqual(ChartIQDrawingTool.segment, ChartIQDrawingTool(stringValue: segment))
    XCTAssertEqual(ChartIQDrawingTool.speedResistanceArc, ChartIQDrawingTool(stringValue: speedResistanceArc))
    XCTAssertEqual(ChartIQDrawingTool.speedResistanceLine, ChartIQDrawingTool(stringValue: speedResistanceLine))
    XCTAssertEqual(ChartIQDrawingTool.star, ChartIQDrawingTool(stringValue: star))
    XCTAssertEqual(ChartIQDrawingTool.timeCycle, ChartIQDrawingTool(stringValue: timeCycle))
    XCTAssertEqual(ChartIQDrawingTool.tironeLevels, ChartIQDrawingTool(stringValue: tironeLevels))
    XCTAssertEqual(ChartIQDrawingTool.trend, ChartIQDrawingTool(stringValue: trend))
    XCTAssertEqual(ChartIQDrawingTool.vertical, ChartIQDrawingTool(stringValue: vertical))
    XCTAssertEqual(ChartIQDrawingTool.noTool, ChartIQDrawingTool(stringValue: noTool))
    XCTAssertEqual(ChartIQDrawingTool.measure, ChartIQDrawingTool(stringValue: measure))

    XCTAssertNil(ChartIQDrawingTool(stringValue: invalidString))
  }
}
