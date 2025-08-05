//
//  ChartIQDrawingManagerTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
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

  func testsChartIQDrawingManagerIsToolSupportingFillColor() {
    // Given
    let annotation = false
    let arrow = true
    let average = false
    let callout = true, channel = true
    let continuous = false
    let crossline = false, doodle = false, elliottWave = false
    let ellipse = true, fibArc = true, fibFan = true, fibProjection = true, fibRetracement = true, fibTimeZone = true
    let gannFan = true, gartley = true
    let horizontal = false, line = false
    let measurementLine = true
    let pitchfork = false
    let quadrantLines = true
    let ray = false
    let rectangle = true
    let regression = false
    let speedResistanceArc = true, speedResistanceLine = true
    let timeCycle = true, tironeLevels = true, trendLine = true
    let vertical = false
    let volumeProfile = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingFillColor(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingFillColor(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingFillColor(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingFillColor(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingFillColor(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingFillColor(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingFillColor(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingFillColor(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingFillColor(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingFillColor(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingFillColor(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingFillColor(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingFillColor(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingFillColor(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingFillColor(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingFillColor(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingFillColor(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingFillColor(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingFillColor(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingFillColor(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingFillColor(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingFillColor(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingFillColor(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingFillColor(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingFillColor(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingFillColor(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingFillColor(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingFillColor(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingFillColor(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingFillColor(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingFillColor(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingFillColor(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingFillColor(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingLineColor() {
    // Given
    let annotation = true, arrow = true, average = true, callout = true, channel = true
    let continuous = true, crossline = true, doodle = true, elliottWave = true, ellipse = true
    let fibArc = true, fibFan = true, fibProjection = true, fibRetracement = true, fibTimeZone = true
    let gannFan = true, gartley = true, horizontal = true, line = true, measurementLine = true, pitchfork = true
    let quadrantLines = true, ray = true, rectangle = true, regression = true, speedResistanceArc = true
    let speedResistanceLine = true, timeCycle = true, tironeLevels = true, trendLine = true, vertical = true
    let volumeProfile = true, measure = true

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingLineColor(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingLineColor(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingLineColor(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingLineColor(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingLineColor(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingLineColor(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingLineColor(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingLineColor(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingLineColor(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingLineColor(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingLineColor(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingLineColor(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingLineColor(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingLineColor(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingLineColor(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingLineColor(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingLineColor(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingLineColor(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingLineColor(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingLineColor(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingLineColor(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingLineColor(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingLineColor(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingLineColor(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingLineColor(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingLineColor(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingLineColor(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingLineColor(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingLineColor(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingLineColor(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingLineColor(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingLineColor(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingLineColor(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingLineType() {
    // Given
    let annotation = false
    let arrow = true, average = true, callout = true, channel = true, continuous = true
    let crossline = true, doodle = true, elliottWave = true, ellipse = true, fibArc = true, fibFan = true
    let fibProjection = true, fibRetracement = true, fibTimeZone = true, gannFan = true, gartley = true
    let horizontal = true, line = true, measurementLine = true, pitchfork = true, quadrantLines = true
    let ray = true, rectangle = true, regression = true, speedResistanceArc = true, speedResistanceLine = true
    let timeCycle = true, tironeLevels = true, trendLine = true, vertical = true, volumeProfile = true
    let measure = true

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingLineType(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingLineType(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingLineType(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingLineType(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingLineType(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingLineType(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingLineType(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingLineType(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingLineType(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingLineType(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingLineType(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingLineType(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingLineType(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingLineType(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingLineType(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingLineType(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingLineType(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingLineType(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingLineType(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingLineType(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingLineType(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingLineType(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingLineType(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingLineType(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingLineType(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingLineType(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingLineType(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingLineType(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingLineType(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingLineType(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingLineType(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingLineType(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingLineType(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingSettings() {
    // Given
    let annotation = true, arrow = true, average = true, callout = true, channel = true, continuous = true
    let crossline = true, doodle = true, elliottWave = true, ellipse = true, fibArc = true, fibFan = true
    let fibProjection = true, fibRetracement = true, fibTimeZone = true, gannFan = true, gartley = true
    let horizontal = true, line = true, measurementLine = true, pitchfork = true, quadrantLines = true
    let ray = true, rectangle = true, regression = true, speedResistanceArc = true, speedResistanceLine = true
    let timeCycle = true, tironeLevels = true, trendLine = true, vertical = true, volumeProfile = true
    let measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingSettings(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingSettings(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingSettings(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingSettings(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingSettings(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingSettings(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingSettings(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingSettings(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingSettings(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingSettings(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingSettings(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingSettings(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingSettings(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingSettings(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingSettings(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingSettings(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingSettings(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingSettings(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingSettings(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingSettings(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingSettings(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingSettings(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingSettings(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingSettings(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingSettings(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingSettings(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingSettings(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingSettings(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingSettings(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingSettings(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingSettings(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingSettings(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingSettings(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingFont() {
    // Given
    let annotation = true
    let arrow = false, average = false
    let callout = true
    let channel = false, continuous = false, crossline = false, doodle = false
    let elliottWave = true
    let ellipse = false, fibArc = false, fibFan = false, fibProjection = false, fibRetracement = false
    let fibTimeZone = false, gannFan = false, gartley = false, horizontal = false
    let line = false, measurementLine = false, pitchfork = false, quadrantLines = false, ray = false, rectangle = false
    let regression = false, speedResistanceArc = false, speedResistanceLine = false, timeCycle = false
    let tironeLevels = false
    let trendLine = true
    let vertical = false, volumeProfile = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingFont(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingFont(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingFont(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingFont(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingFont(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingFont(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingFont(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingFont(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingFont(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingFont(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingFont(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingFont(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingFont(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingFont(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingFont(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingFont(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingFont(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingFont(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingFont(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingFont(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingFont(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingFont(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingFont(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingFont(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingFont(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingFont(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingFont(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingFont(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingFont(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingFont(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingFont(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingFont(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingFont(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingAxisLabel() {
    // Given
    let annotation = false, arrow = false
    let average = true
    let callout = false, channel = false, continuous = false
    let crossline = true
    let doodle = false, elliottWave = false, ellipse = false, fibArc = false, fibFan = false, fibProjection = false
    let fibRetracement = false, fibTimeZone = false, gannFan = false, gartley = false
    let horizontal = true
    let line = false
    let measurementLine = true
    let pitchfork = false, quadrantLines = false
    let ray = false, rectangle = false, regression = false, speedResistanceArc = false
    let speedResistanceLine = false, timeCycle = false, tironeLevels = false, trendLine = false
    let vertical = true
    let volumeProfile = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingAxisLabel(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingAxisLabel(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingAxisLabel(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingAxisLabel(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingAxisLabel(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingAxisLabel(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingAxisLabel(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingAxisLabel(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingAxisLabel(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingAxisLabel(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingAxisLabel(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingAxisLabel(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingAxisLabel(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingAxisLabel(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingAxisLabel(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingAxisLabel(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingAxisLabel(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingAxisLabel(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingAxisLabel(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingAxisLabel(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingAxisLabel(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingAxisLabel(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingAxisLabel(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingAxisLabel(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingAxisLabel(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingAxisLabel(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingAxisLabel(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingAxisLabel(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingAxisLabel(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingAxisLabel(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingAxisLabel(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingAxisLabel(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingAxisLabel(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingStdDeviations() {
    // Given
    let annotation = false, arrow = false
    let average = true
    let callout = false, channel = false
    let continuous = false, crossline = false, doodle = false
    let elliottWave = false, ellipse = false, fibArc = false, fibFan = false, fibProjection = false
    let fibRetracement = false, fibTimeZone = false, gannFan = false, gartley = false
    let horizontal = false, line = false, measurementLine = false, pitchfork = false, quadrantLines = false, ray = false
    let regression = true
    let rectangle = false, speedResistanceArc = false, speedResistanceLine = false, timeCycle = false
    let tironeLevels = false, trendLine = false, vertical = false, volumeProfile = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingDeviations(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingDeviations(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingDeviations(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingDeviations(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingDeviations(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingDeviations(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingDeviations(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingDeviations(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingDeviations(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingDeviations(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingDeviations(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingDeviations(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingDeviations(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingDeviations(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingDeviations(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingDeviations(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingDeviations(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingDeviations(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingDeviations(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingDeviations(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingDeviations(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingDeviations(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingDeviations(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingDeviations(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingDeviations(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingDeviations(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingDeviations(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingDeviations(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingDeviations(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingDeviations(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingDeviations(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingDeviations(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingDeviations(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingFibonacci() {
    // Given
    let annotation = false, arrow = false, average = false, callout = false, channel = false, continuous = false
    let crossline = false, doodle = false, elliottWave = false, ellipse = false, fibArc = true, fibFan = true
    let fibProjection = true, fibRetracement = true
    let fibTimeZone = false, gannFan = false, gartley = false, horizontal = false
    let line = false, measurementLine = false, pitchfork = false, quadrantLines = false, ray = false, rectangle = false
    let regression = false, speedResistanceArc = false, speedResistanceLine = false, timeCycle = false
    let tironeLevels = false, trendLine = false, vertical = false, volumeProfile = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingFibonacci(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingFibonacci(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingFibonacci(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingFibonacci(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingFibonacci(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingFibonacci(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingFibonacci(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingFibonacci(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingFibonacci(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingFibonacci(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingFibonacci(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingFibonacci(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingFibonacci(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingFibonacci(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingFibonacci(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingFibonacci(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingFibonacci(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingFibonacci(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingFibonacci(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingFibonacci(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingFibonacci(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingFibonacci(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingFibonacci(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingFibonacci(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingFibonacci(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingFibonacci(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingFibonacci(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingFibonacci(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingFibonacci(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingFibonacci(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingFibonacci(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingFibonacci(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingFibonacci(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingElliottWave() {
    // Given
    let annotation = false, arrow = false, average = false, callout = false, channel = false
    let continuous = false, crossline = false, doodle = false
    let elliottWave = true
    let ellipse = false, fibArc = false, fibFan = false, fibProjection = false, fibRetracement = false, fibTimeZone = false
    let gannFan = false, gartley = false, horizontal = false
    let line = false, measurementLine = false, pitchfork = false, quadrantLines = false, ray = false, rectangle = false
    let regression = false, speedResistanceArc = false, speedResistanceLine = false, timeCycle = false
    let tironeLevels = false, trendLine = false, vertical = false, volumeProfile = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingElliottWave(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingElliottWave(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingElliottWave(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingElliottWave(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingElliottWave(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingElliottWave(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingElliottWave(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingElliottWave(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingElliottWave(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingElliottWave(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingElliottWave(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingElliottWave(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingElliottWave(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingElliottWave(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingElliottWave(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingElliottWave(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingElliottWave(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingElliottWave(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingElliottWave(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingElliottWave(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingElliottWave(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingElliottWave(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingElliottWave(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingElliottWave(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingElliottWave(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingElliottWave(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingElliottWave(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingElliottWave(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingElliottWave(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingElliottWave(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingElliottWave(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingElliottWave(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingElliottWave(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingVolumeProfile() {
    // Given
    let annotation = false, arrow = false, average = false, callout = false, channel = false, continuous = false
    let crossline = false, doodle = false, elliottWave = false, ellipse = false, fibArc = false, fibFan = false
    let fibProjection = false, fibRetracement = false, fibTimeZone = false, gannFan = false, gartley = false, horizontal = false
    let line = false, measurementLine = false, pitchfork = false, quadrantLines = false, ray = false, rectangle = false
    let regression = false, speedResistanceArc = false, speedResistanceLine = false, timeCycle = false
    let tironeLevels = false, trendLine = false, vertical = false, volumeProfile = true, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingVolumeProfile(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingVolumeProfile(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingVolumeProfile(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingVolumeProfile(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingVolumeProfile(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingVolumeProfile(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingVolumeProfile(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingVolumeProfile(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingVolumeProfile(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingVolumeProfile(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingVolumeProfile(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingVolumeProfile(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingVolumeProfile(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingVolumeProfile(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingVolumeProfile(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingVolumeProfile(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingVolumeProfile(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingVolumeProfile(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingVolumeProfile(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingVolumeProfile(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingVolumeProfile(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingVolumeProfile(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingVolumeProfile(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingVolumeProfile(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingVolumeProfile(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingVolumeProfile(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingVolumeProfile(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingVolumeProfile(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingVolumeProfile(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingVolumeProfile(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingVolumeProfile(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingVolumeProfile(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingVolumeProfile(.measure))
  }

  func testsChartIQDrawingManagerIsToolSupportingShowCallout() {
    // Given
    let annotation = false, arrow = false, average = false, callout = false, channel = false, continuous = false
    let crossline = false, doodle = false, elliottWave = false, ellipse = false, fibArc = false, fibFan = false
    let fibProjection = false, fibRetracement = false, fibTimeZone = false, gannFan = false, gartley = false, horizontal = false
    let line = false, measurementLine = false, pitchfork = false, quadrantLines = false, ray = false, rectangle = false
    let regression = false, speedResistanceArc = false, speedResistanceLine = false, timeCycle = false
    let tironeLevels = false, trendLine = true, vertical = false, volumeProfile = false, measure = false

    // When // Then
    XCTAssertEqual(annotation, chartIQDrawingManager.isSupportingShowCallout(.annotation))
    XCTAssertEqual(arrow, chartIQDrawingManager.isSupportingShowCallout(.arrow))
    XCTAssertEqual(average, chartIQDrawingManager.isSupportingShowCallout(.average))
    XCTAssertEqual(callout, chartIQDrawingManager.isSupportingShowCallout(.callout))
    XCTAssertEqual(channel, chartIQDrawingManager.isSupportingShowCallout(.channel))
    XCTAssertEqual(continuous, chartIQDrawingManager.isSupportingShowCallout(.continuous))
    XCTAssertEqual(crossline, chartIQDrawingManager.isSupportingShowCallout(.crossline))
    XCTAssertEqual(doodle, chartIQDrawingManager.isSupportingShowCallout(.doodle))
    XCTAssertEqual(elliottWave, chartIQDrawingManager.isSupportingShowCallout(.elliottWave))
    XCTAssertEqual(ellipse, chartIQDrawingManager.isSupportingShowCallout(.ellipse))
    XCTAssertEqual(fibArc, chartIQDrawingManager.isSupportingShowCallout(.fibArc))
    XCTAssertEqual(fibFan, chartIQDrawingManager.isSupportingShowCallout(.fibFan))
    XCTAssertEqual(fibProjection, chartIQDrawingManager.isSupportingShowCallout(.fibProjection))
    XCTAssertEqual(fibRetracement, chartIQDrawingManager.isSupportingShowCallout(.fibRetracement))
    XCTAssertEqual(fibTimeZone, chartIQDrawingManager.isSupportingShowCallout(.fibTimeZone))
    XCTAssertEqual(gannFan, chartIQDrawingManager.isSupportingShowCallout(.gannFan))
    XCTAssertEqual(gartley, chartIQDrawingManager.isSupportingShowCallout(.gartley))
    XCTAssertEqual(horizontal, chartIQDrawingManager.isSupportingShowCallout(.horizontal))
    XCTAssertEqual(line, chartIQDrawingManager.isSupportingShowCallout(.line))
    XCTAssertEqual(measurementLine, chartIQDrawingManager.isSupportingShowCallout(.measurementLine))
    XCTAssertEqual(pitchfork, chartIQDrawingManager.isSupportingShowCallout(.pitchfork))
    XCTAssertEqual(quadrantLines, chartIQDrawingManager.isSupportingShowCallout(.quadrantLines))
    XCTAssertEqual(ray, chartIQDrawingManager.isSupportingShowCallout(.ray))
    XCTAssertEqual(rectangle, chartIQDrawingManager.isSupportingShowCallout(.rectangle))
    XCTAssertEqual(regression, chartIQDrawingManager.isSupportingShowCallout(.regression))
    XCTAssertEqual(speedResistanceArc, chartIQDrawingManager.isSupportingShowCallout(.speedResistanceArc))
    XCTAssertEqual(speedResistanceLine, chartIQDrawingManager.isSupportingShowCallout(.speedResistanceLine))
    XCTAssertEqual(timeCycle, chartIQDrawingManager.isSupportingShowCallout(.timeCycle))
    XCTAssertEqual(tironeLevels, chartIQDrawingManager.isSupportingShowCallout(.tironeLevels))
    XCTAssertEqual(trendLine, chartIQDrawingManager.isSupportingShowCallout(.trendLine))
    XCTAssertEqual(vertical, chartIQDrawingManager.isSupportingShowCallout(.vertical))
    XCTAssertEqual(volumeProfile, chartIQDrawingManager.isSupportingShowCallout(.volumeProfile))
    XCTAssertEqual(measure, chartIQDrawingManager.isSupportingShowCallout(.measure))
  }
}
