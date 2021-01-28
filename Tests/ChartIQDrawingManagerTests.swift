//
//  ChartIQDrawingManagerTests.swift
//  ChartIQTests
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQDrawingManagerTests: XCTestCase {

  let chartIQDrawingManager = ChartIQDrawingManager()

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests ChartIQDrawing Manager

  func testsChartIQDrawingManagerisToolSupportingFillColor() {
    // Given
    let annotation = false
    let arrow = true
    let average = false
    let callout = true
    let channel = true
    let check = true
    let continuous = false
    let cross = true
    let crossline = false
    let doodle = false
    let elliottWave = false
    let ellipse = true
    let fibArc = true
    let fibFan = true
    let fibProjection = true
    let fibRetracement = true
    let fibTimeZone = true
    let focus = true
    let gannFan = true
    let gartley = true
    let heart = true
    let horizontal = false
    let line = false
    let pitchfork = false
    let quadrantLines = true
    let ray = false
    let rectangle = true
    let regression = false
    let segment = false
    let speedResistanceArc = true
    let speedResistanceLine = true
    let star = true
    let timeCycle = true
    let tironeLevels = true
    let trend = true
    let vertical = false
    let noTool = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingFillColor(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingFillColor(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingFillColor(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingFillColor(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingFillColor(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingFillColor(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingFillColor(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingFillColor(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingFillColor(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingFillColor(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingFillColor(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingFillColor(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingFillColor(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingFillColor(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingFillColor(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingFillColor(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingFillColor(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingFillColor(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingFillColor(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingFillColor(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingFillColor(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingFillColor(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingFillColor(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingFillColor(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingFillColor(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingFillColor(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingFillColor(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingFillColor(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingFillColor(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingFillColor(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingFillColor(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingFillColor(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingFillColor(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingFillColor(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingFillColor(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingFillColor(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingFillColor(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingFillColor(.measure))
  }

  func testsChartIQDrawingManagerisToolSupportingLineColor() {
    // Given
    let annotation = true
    let arrow = true
    let average = true
    let callout = true
    let channel = true
    let check = true
    let continuous = true
    let cross = true
    let crossline = true
    let doodle = true
    let elliottWave = true
    let ellipse = true
    let fibArc = true
    let fibFan = true
    let fibProjection = true
    let fibRetracement = true
    let fibTimeZone = true
    let focus = true
    let gannFan = true
    let gartley = true
    let heart = true
    let horizontal = true
    let line = true
    let pitchfork = true
    let quadrantLines = true
    let ray = true
    let rectangle = true
    let regression = true
    let segment = true
    let speedResistanceArc = true
    let speedResistanceLine = true
    let star = true
    let timeCycle = true
    let tironeLevels = true
    let trend = true
    let vertical = true
    let noTool = false
    let measure = true

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingLineColor(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingLineColor(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingLineColor(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingLineColor(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingLineColor(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingLineColor(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingLineColor(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingLineColor(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingLineColor(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingLineColor(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingLineColor(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingLineColor(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingLineColor(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingLineColor(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingLineColor(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingLineColor(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingLineColor(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingLineColor(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingLineColor(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingLineColor(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingLineColor(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingLineColor(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingLineColor(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingLineColor(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingLineColor(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingLineColor(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingLineColor(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingLineColor(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingLineColor(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingLineColor(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingLineColor(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingLineColor(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingLineColor(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingLineColor(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingLineColor(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingLineColor(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingLineColor(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingLineColor(.measure))
  }

  func testsChartIQDrawingManagerisToolSupportingLineType() {
    // Given
    let annotation = false
    let arrow = true
    let average = true
    let callout = true
    let channel = true
    let check = true
    let continuous = true
    let cross = true
    let crossline = true
    let doodle = true
    let elliottWave = true
    let ellipse = true
    let fibArc = true
    let fibFan = true
    let fibProjection = true
    let fibRetracement = true
    let fibTimeZone = true
    let focus = true
    let gannFan = true
    let gartley = true
    let heart = true
    let horizontal = true
    let line = true
    let pitchfork = true
    let quadrantLines = true
    let ray = true
    let rectangle = true
    let regression = true
    let segment = true
    let speedResistanceArc = true
    let speedResistanceLine = true
    let star = true
    let timeCycle = true
    let tironeLevels = true
    let trend = true
    let vertical = true
    let noTool = false
    let measure = true

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingLineType(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingLineType(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingLineType(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingLineType(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingLineType(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingLineType(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingLineType(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingLineType(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingLineType(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingLineType(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingLineType(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingLineType(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingLineType(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingLineType(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingLineType(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingLineType(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingLineType(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingLineType(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingLineType(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingLineType(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingLineType(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingLineType(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingLineType(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingLineType(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingLineType(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingLineType(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingLineType(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingLineType(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingLineType(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingLineType(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingLineType(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingLineType(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingLineType(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingLineType(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingLineType(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingLineType(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingLineType(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingLineType(.measure))
  }

  func testsChartIQDrawingManagerisToolSupportingSettings() {
    // Given
    let annotation = true
    let arrow = true
    let average = true
    let callout = true
    let channel = true
    let check = true
    let continuous = true
    let cross = true
    let crossline = true
    let doodle = true
    let elliottWave = true
    let ellipse = true
    let fibArc = true
    let fibFan = true
    let fibProjection = true
    let fibRetracement = true
    let fibTimeZone = true
    let focus = true
    let gannFan = true
    let gartley = true
    let heart = true
    let horizontal = true
    let line = true
    let pitchfork = true
    let quadrantLines = true
    let ray = true
    let rectangle = true
    let regression = true
    let segment = true
    let speedResistanceArc = true
    let speedResistanceLine = true
    let star = true
    let timeCycle = true
    let tironeLevels = true
    let trend = true
    let vertical = true
    let noTool = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingSettings(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingSettings(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingSettings(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingSettings(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingSettings(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingSettings(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingSettings(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingSettings(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingSettings(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingSettings(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingSettings(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingSettings(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingSettings(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingSettings(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingSettings(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingSettings(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingSettings(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingSettings(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingSettings(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingSettings(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingSettings(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingSettings(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingSettings(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingSettings(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingSettings(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingSettings(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingSettings(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingSettings(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingSettings(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingSettings(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingSettings(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingSettings(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingSettings(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingSettings(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingSettings(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingSettings(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingSettings(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingSettings(.measure))
  }

  func testsChartIQDrawingManagerisToolSupportingFont() {
    // Given
    let annotation = true
    let arrow = false
    let average = false
    let callout = true
    let channel = false
    let check = false
    let continuous = false
    let cross = false
    let crossline = false
    let doodle = false
    let elliottWave = true
    let ellipse = false
    let fibArc = false
    let fibFan = false
    let fibProjection = false
    let fibRetracement = false
    let fibTimeZone = false
    let focus = false
    let gannFan = false
    let gartley = false
    let heart = false
    let horizontal = false
    let line = false
    let pitchfork = false
    let quadrantLines = false
    let ray = false
    let rectangle = false
    let regression = false
    let segment = false
    let speedResistanceArc = false
    let speedResistanceLine = false
    let star = false
    let timeCycle = false
    let tironeLevels = false
    let trend = true
    let vertical = false
    let noTool = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingFont(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingFont(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingFont(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingFont(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingFont(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingFont(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingFont(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingFont(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingFont(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingFont(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingFont(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingFont(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingFont(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingFont(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingFont(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingFont(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingFont(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingFont(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingFont(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingFont(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingFont(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingFont(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingFont(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingFont(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingFont(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingFont(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingFont(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingFont(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingFont(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingFont(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingFont(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingFont(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingFont(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingFont(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingFont(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingFont(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingFont(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingFont(.measure))
  }

  func testsChartIQDrawingManagerisToolSupportingAxisLabel() {
    // Given
    let annotation = false, arrow = false
    let average = true
    let callout = false, channel = false, check = false, continuous = false, cross = false
    let crossline = true
    let doodle = false, elliottWave = false, ellipse = false, fibArc = false, fibFan = false, fibProjection = false
    let fibRetracement = false, fibTimeZone = false, focus = false, gannFan = false, gartley = false, heart = false
    let horizontal = true
    let line = false, pitchfork = false, quadrantLines = false
    let ray = false, rectangle = false, regression = false, segment = false, speedResistanceArc = false
    let speedResistanceLine = false, star = false, timeCycle = false, tironeLevels = false, trend = false
    let vertical = true
    let noTool = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingAxisLabel(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingAxisLabel(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingAxisLabel(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingAxisLabel(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingAxisLabel(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingAxisLabel(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingAxisLabel(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingAxisLabel(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingAxisLabel(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingAxisLabel(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingAxisLabel(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingAxisLabel(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingAxisLabel(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingAxisLabel(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingAxisLabel(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingAxisLabel(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingAxisLabel(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingAxisLabel(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingAxisLabel(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingAxisLabel(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingAxisLabel(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingAxisLabel(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingAxisLabel(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingAxisLabel(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingAxisLabel(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingAxisLabel(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingAxisLabel(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingAxisLabel(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingAxisLabel(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingAxisLabel(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingAxisLabel(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingAxisLabel(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingAxisLabel(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingAxisLabel(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingAxisLabel(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingAxisLabel(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingAxisLabel(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingAxisLabel(.measure))
  }

  func testsChartIQDrawingManagerisToolSupportingStdDeviations() {
    // Given
    let annotation = false, arrow = false
    let average = true
    let callout = false, channel = false
    let check = false, continuous = false, cross = false, crossline = false, doodle = false
    let elliottWave = false, ellipse = false, fibArc = false, fibFan = false, fibProjection = false
    let fibRetracement = false, fibTimeZone = false, focus = false, gannFan = false, gartley = false, heart = false
    let horizontal = false, line = false, pitchfork = false, quadrantLines = false, ray = false, rectangle = false
    let regression = true
    let segment = false, speedResistanceArc = false, speedResistanceLine = false
    let star = false, timeCycle = false, tironeLevels = false, trend = false, vertical = false
    let noTool = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingDeviations(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingDeviations(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingDeviations(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingDeviations(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingDeviations(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingDeviations(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingDeviations(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingDeviations(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingDeviations(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingDeviations(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingDeviations(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingDeviations(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingDeviations(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingDeviations(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingDeviations(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingDeviations(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingDeviations(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingDeviations(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingDeviations(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingDeviations(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingDeviations(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingDeviations(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingDeviations(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingDeviations(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingDeviations(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingDeviations(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingDeviations(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingDeviations(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingDeviations(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingDeviations(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingDeviations(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingDeviations(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingDeviations(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingDeviations(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingDeviations(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingDeviations(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingDeviations(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingDeviations(.measure))
  }

  func testsChartIQDrawingManagerisToolSupportingFibonacci() {
    // Given
    let annotation = false, arrow = false
    let average = false, callout = false, channel = false, check = false, continuous = false
    let cross = false, crossline = false, doodle = false, elliottWave = false, ellipse = false
    let fibArc = true, fibFan = true, fibProjection = true, fibRetracement = true
    let fibTimeZone = false, focus = false, gannFan = false, gartley = false, heart = false, horizontal = false
    let line = false, pitchfork = false, quadrantLines = false, ray = false, rectangle = false
    let regression = false, segment = false, speedResistanceArc = false, speedResistanceLine = false
    let star = false, timeCycle = false, tironeLevels = false, trend = false, vertical = false
    let noTool = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingFibonacci(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingFibonacci(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingFibonacci(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingFibonacci(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingFibonacci(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingFibonacci(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingFibonacci(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingFibonacci(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingFibonacci(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingFibonacci(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingFibonacci(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingFibonacci(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingFibonacci(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingFibonacci(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingFibonacci(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingFibonacci(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingFibonacci(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingFibonacci(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingFibonacci(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingFibonacci(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingFibonacci(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingFibonacci(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingFibonacci(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingFibonacci(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingFibonacci(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingFibonacci(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingFibonacci(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingFibonacci(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingFibonacci(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingFibonacci(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingFibonacci(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingFibonacci(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingFibonacci(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingFibonacci(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingFibonacci(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingFibonacci(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingFibonacci(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingFibonacci(.measure))
  }

  func testsChartIQDrawingManagerisToolSupportingElliottWave() {
    // Given
    let annotation = false, arrow = false, average = false, callout = false, channel = false
    let check = false, continuous = false, cross = false, crossline = false, doodle = false
    let elliottWave = true
    let ellipse = false, fibArc = false
    let fibFan = false, fibProjection = false, fibRetracement = false, fibTimeZone = false
    let focus = false, gannFan = false, gartley = false, heart = false, horizontal = false
    let line = false, pitchfork = false, quadrantLines = false, ray = false, rectangle = false
    let regression = false, segment = false, speedResistanceArc = false, speedResistanceLine = false
    let star = false, timeCycle = false, tironeLevels = false, trend = false, vertical = false
    let noTool = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingElliottWave(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingElliottWave(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingElliottWave(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingElliottWave(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingElliottWave(.channel))
    XCTAssertEqual(check, chartIQDrawingManager.isSupportingElliottWave(.check))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingElliottWave(.continuous))
    XCTAssertEqual(cross, chartIQDrawingManager.isSupportingElliottWave(.cross))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingElliottWave(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingElliottWave(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingElliottWave(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingElliottWave(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingElliottWave(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingElliottWave(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingElliottWave(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingElliottWave(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingElliottWave(.fibTimeZone))
    XCTAssertEqual(focus, chartIQDrawingManager.isSupportingElliottWave(.focus))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingElliottWave(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingElliottWave(.gartley))
    XCTAssertEqual(heart, chartIQDrawingManager.isSupportingElliottWave(.heart))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingElliottWave(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingElliottWave(.line))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingElliottWave(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingElliottWave(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingElliottWave(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingElliottWave(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingElliottWave(.regression))
    XCTAssertEqual(segment, chartIQDrawingManager.isSupportingElliottWave(.segment))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingElliottWave(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingElliottWave(.speedResistanceLine))
    XCTAssertEqual(star, chartIQDrawingManager.isSupportingElliottWave(.star))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingElliottWave(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingElliottWave(.tironeLevels))
    XCTAssertEqual(trend, chartIQDrawingManager.isSupportingElliottWave(.trend))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingElliottWave(.vertical))
    XCTAssertEqual(noTool, chartIQDrawingManager.isSupportingElliottWave(.noTool))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingElliottWave(.measure))
  }
}
