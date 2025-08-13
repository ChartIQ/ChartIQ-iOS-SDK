//
//  ChartIQDrawingToolEnums.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQDrawingTool Enum

/// Chart drawing tool.
@objc public enum ChartIQDrawingTool: Int {

  /// The annotation option.
  case annotation

  /// The arrow option.
  case arrow

  /// The average option.
  case average

  /// The callout option.
  case callout

  /// The channel option.
  case channel

  /// The continuous option.
  case continuous

  /// The crossline option.
  case crossline

  /// The doodle option.
  case doodle

  /// The elliottWave option.
  case elliottWave

  /// The ellipse option.
  case ellipse

  /// The fibArc option.
  case fibArc

  /// The fibFan option.
  case fibFan

  /// The fibProjection option.
  case fibProjection

  /// The fibRetracement option.
  case fibRetracement

  /// The fibTimeZone option.
  case fibTimeZone

  /// The gannFan option.
  case gannFan

  /// The gartley option.
  case gartley

  /// The horizontal option.
  case horizontal

  /// The line option.
  case line

  /// The measurementLine option.
  case measurementLine

  /// The pitchfork option.
  case pitchfork

  /// The quadrantLines option.
  case quadrantLines

  /// The ray option.
  case ray

  /// The rectangle option.
  case rectangle

  /// The regression option.
  case regression

  /// The speedResistanceArc option.
  case speedResistanceArc

  /// The speedResistanceLine option.
  case speedResistanceLine

  /// The timeCycle option.
  case timeCycle

  /// The tironeLevels option.
  case tironeLevels

  /// The trend option.
  case trendLine

  /// The vertical option.
  case vertical

  /// The volumeProfile option.
  case volumeProfile

  /// The measure option.
  case measure

  /// Chart drawing tool string value.
  public var stringValue: String {
    switch self {
    case .annotation:
      return "annotation"
    case .arrow:
      return "arrowline"
    case .average:
      return "average"
    case .callout:
      return "callout"
    case .channel:
      return "channel"
    case .continuous:
      return "continuous"
    case .crossline:
      return "crossline"
    case .doodle:
      return "freeform"
    case .elliottWave:
      return "elliottwave"
    case .ellipse:
      return "ellipse"
    case .fibArc:
      return "fibarc"
    case .fibFan:
      return "fibfan"
    case .fibProjection:
      return "fibprojection"
    case .fibRetracement:
      return "retracement"
    case .fibTimeZone:
      return "fibtimezone"
    case .gannFan:
      return "gannfan"
    case .gartley:
      return "gartley"
    case .horizontal:
      return "horizontal"
    case .line:
      return "line"
    case .measurementLine:
        return "measurementline"
    case .pitchfork:
      return "pitchfork"
    case .quadrantLines:
      return "quadrant"
    case .ray:
      return "ray"
    case .rectangle:
      return "rectangle"
    case .regression:
      return "regression"
    case .speedResistanceArc:
      return "speedarc"
    case .speedResistanceLine:
      return "speedline"
    case .timeCycle:
      return "timecycle"
    case .tironeLevels:
      return "tirone"
    case .trendLine:
      return "trendline"
    case .vertical:
      return "vertical"
    case .volumeProfile:
      return "volumeprofile"
    case .measure:
      return "measure"
    }
  }

  /// Chart drawing tool display name.
  public var displayName: String {
    switch self {
    case .annotation:
      return "Annotation"
    case .arrow:
      return "Arrow"
    case .average:
      return "Average Line"
    case .callout:
      return "Callout"
    case .channel:
      return "Channel"
    case .continuous:
      return "Continuous"
    case .crossline:
      return "Crossline"
    case .doodle:
      return "Doodle"
    case .elliottWave:
      return "Elliott Wave"
    case .ellipse:
      return "Ellipse"
    case .fibArc:
      return "Fib Arc"
    case .fibFan:
      return "Fib Fan"
    case .fibProjection:
      return "Fib Projection"
    case .fibRetracement:
      return "Fib Retracement"
    case .fibTimeZone:
      return "Fib Time Zone"
    case .gannFan:
      return "Gann Fan"
    case .gartley:
      return "Gartley"
    case .horizontal:
      return "Horizontal"
    case .line:
      return "Line"
    case .measurementLine:
      return "Measurement Line"
    case .pitchfork:
      return "Pitchfork"
    case .quadrantLines:
      return "Quadrant Lines"
    case .ray:
      return "Ray"
    case .rectangle:
      return "Rectangle"
    case .regression:
      return "Regression Line"
    case .speedResistanceArc:
      return "Speed Resistance Arc"
    case .speedResistanceLine:
      return "Speed Resistance Line"
    case .timeCycle:
      return "Time Cycle"
    case .tironeLevels:
      return "Tirone Levels"
    case .trendLine:
      return "Trend Line"
    case .vertical:
      return "Vertical"
    case .volumeProfile:
      return "Volume Profile"
    case .measure:
      return "Measure"
    }
  }

  /// Chart drawing tool type.
  public var type: ChartIQDrawingToolType {
    switch self {
    case .annotation:
      return .text
    case .arrow:
      return .markings
    case .average:
      return .statistics
    case .callout:
      return .text
    case .channel:
      return .lines
    case .continuous:
      return .lines
    case .crossline:
      return .lines
    case .doodle:
      return .lines
    case .elliottWave:
      return .technicals
    case .ellipse:
      return .markings
    case .fibArc:
      return .fibonacci
    case .fibFan:
      return .fibonacci
    case .fibProjection:
      return .fibonacci
    case .fibRetracement:
      return .fibonacci
    case .fibTimeZone:
      return .fibonacci
    case .gannFan:
      return .technicals
    case .gartley:
      return .technicals
    case .horizontal:
      return .lines
    case .line:
      return .lines
    case .measurementLine:
      return .statistics
    case .pitchfork:
      return .technicals
    case .quadrantLines:
      return .statistics
    case .ray:
      return .lines
    case .rectangle:
      return .markings
    case .regression:
      return .statistics
    case .speedResistanceArc:
      return .technicals
    case .speedResistanceLine:
      return .technicals
    case .timeCycle:
      return .technicals
    case .tironeLevels:
      return .statistics
    case .trendLine:
      return .lines
    case .vertical:
      return .lines
    case .volumeProfile:
      return .statistics
    case .measure:
      return .text
    }
  }

  /// Init drawing tool with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQDrawingTool] = [
      "annotation": .annotation,
      "arrowline": .arrow,
      "average": .average,
      "callout": .callout,
      "channel": .channel,
      "continuous": .continuous,
      "crossline": .crossline,
      "freeform": .doodle,
      "elliottwave": .elliottWave,
      "ellipse": .ellipse,
      "fibarc": .fibArc,
      "fibfan": .fibFan,
      "fibprojection": .fibProjection,
      "retracement": .fibRetracement,
      "fibtimezone": .fibTimeZone,
      "gannfan": .gannFan,
      "gartley": .gartley,
      "horizontal": .horizontal,
      "line": .line,
      "measurementline": .measurementLine,
      "pitchfork": .pitchfork,
      "quadrant": .quadrantLines,
      "ray": .ray,
      "rectangle": .rectangle,
      "regression": .regression,
      "speedarc": .speedResistanceArc,
      "speedline": .speedResistanceLine,
      "timecycle": .timeCycle,
      "tirone": .tironeLevels,
      "trendline": .trendLine,
      "vertical": .vertical,
      "volumeprofile": .volumeProfile,
      "measure": .measure
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQDrawingToolType Enum

/// Chart drawing tool type.
@objc public enum ChartIQDrawingToolType: Int {

  /// The text option.
  case text

  /// The statistics option.
  case statistics

  /// The technicals option.
  case technicals

  /// The fibonacci option.
  case fibonacci

  /// The markings option.
  case markings

  /// The lines option.
  case lines

  /// Chart drawing tool type display name.
  public var displayName: String {
    switch self {
    case .text:
      return "Text"
    case .statistics:
      return "Statistics"
    case .technicals:
      return "Technicals"
    case .fibonacci:
      return "Fibonacci"
    case .markings:
      return "Markings"
    case .lines:
      return "Lines"
    }
  }
}

// MARK: - ChartIQDrawingParameterType Enum

/// Chart drawing parameter type.
@objc public enum ChartIQDrawingParameterType: Int {

  /// The fillColor option.
  case fillColor

  /// The lineColor option.
  case lineColor

  /// The pattern option.
  case pattern

  /// The lineWidth option.
  case lineWidth

  /// The family option.
  case family

  /// The size option.
  case size

  /// The style option.
  case style

  /// The weight option.
  case weight

  /// The fibs option.
  case fibs

  /// The axisLabel option.
  case axisLabel

  /// The showLines option.
  case showLines

  /// The showCallout option.
  case showCallout

  /// The waveTemplate option.
  case waveTemplate

  /// The impulse option.
  case impulse

  /// The corrective option.
  case corrective

  /// The decoration option.
  case decoration

  /// The active1 option.
  case active1

  /// The active2 option.
  case active2

  /// The active3 option.
  case active3

  /// The color1 option.
  case color1

  /// The color2 option.
  case color2

  /// The color3 option.
  case color3

  /// The lineWidth1 option.
  case lineWidth1

  /// The lineWidth2 option.
  case lineWidth2

  /// The lineWidth3 option.
  case lineWidth3

  /// The pattern1 option.
  case pattern1

  /// The pattern2 option.
  case pattern2

  /// The pattern3 option.
  case pattern3

  /// The priceBuckets option.
  case priceBuckets

  /// Chart drawing parameter type string value.
  public var stringValue: String {
    switch self {
    case .fillColor:
      return "fillColor"
    case .lineColor:
      return "color"
    case .pattern:
      return "pattern"
    case .lineWidth:
      return "lineWidth"
    case .family:
      return "family"
    case .size:
      return "size"
    case .style:
      return "style"
    case .weight:
      return "weight"
    case .fibs:
      return "fibs"
    case .axisLabel:
      return "axisLabel"
    case .showLines:
      return "showLines"
    case .showCallout:
      return "showCallout"
    case .waveTemplate:
      return "waveTemplate"
    case .impulse:
      return "impulse"
    case .corrective:
      return "corrective"
    case .decoration:
      return "decoration"
    case .active1:
      return "active1"
    case .active2:
      return "active2"
    case .active3:
      return "active3"
    case .color1:
      return "color1"
    case .color2:
      return "color2"
    case .color3:
      return "color3"
    case .lineWidth1:
      return "lineWidth1"
    case .lineWidth2:
      return "lineWidth2"
    case .lineWidth3:
      return "lineWidth3"
    case .pattern1:
      return "pattern1"
    case .pattern2:
      return "pattern2"
    case .pattern3:
      return "pattern3"
    case .priceBuckets:
      return "priceBuckets"
    }
  }
}
