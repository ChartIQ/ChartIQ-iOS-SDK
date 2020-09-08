//
//  ChartIQDrawingTool.swift
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

  /// The check option.
  case check

  /// The continuous option.
  case continuous

  /// The cross option.
  case cross

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

  /// The focus option.
  case focus

  /// The gannFan option.
  case gannFan

  /// The gartley option.
  case gartley

  /// The heart option.
  case heart

  /// The horizontal option.
  case horizontal

  /// The line option.
  case line

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

  /// The segment option.
  case segment

  /// The speedResistanceArc option.
  case speedResistanceArc

  /// The speedResistanceLine option.
  case speedResistanceLine

  /// The star option.
  case star

  /// The timeCycle option.
  case timeCycle

  /// The tironeLevels option.
  case tironeLevels

  /// The trend option.
  case trend

  /// The vertical option.
  case vertical

  /// The noTool option.
  case noTool

  /// The measure option.
  case measure

  /// Chart drawing tool string value.
  public var stringValue: String {
    switch self {
    case .annotation:
      return "annotation"
    case .arrow:
      return "arrow"
    case .average:
      return "average"
    case .callout:
      return "callout"
    case .channel:
      return "channel"
    case .check:
      return "check"
    case .continuous:
      return "continuous"
    case .cross:
      return "xcross"
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
      return "fibonacci"
    case .fibTimeZone:
      return "fibtimezone"
    case .focus:
      return "focusarrow"
    case .gannFan:
      return "gannfan"
    case .gartley:
      return "gartley"
    case .heart:
      return "heart"
    case .horizontal:
      return "horizontal"
    case .line:
      return "line"
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
    case .segment:
      return "segment"
    case .speedResistanceArc:
      return "speedarc"
    case .speedResistanceLine:
      return "speedline"
    case .star:
      return "star"
    case .timeCycle:
      return "timecycle"
    case .tironeLevels:
      return "tirone"
    case .trend:
      return "trendline"
    case .vertical:
      return "vertical"
    case .noTool:
      return "notool"
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
    case .check:
      return "Check"
    case .continuous:
      return "Continuous"
    case .cross:
      return "Cross"
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
    case .focus:
      return "Focus"
    case .gannFan:
      return "Gann Fan"
    case .gartley:
      return "Gartley"
    case .heart:
      return "Heart"
    case .horizontal:
      return "Horizontal"
    case .line:
      return "Line"
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
    case .segment:
      return "Segment"
    case .speedResistanceArc:
      return "Speed Resistance Arc"
    case .speedResistanceLine:
      return "Speed Resistance Line"
    case .star:
      return "Star"
    case .timeCycle:
      return "Time Cycle"
    case .tironeLevels:
      return "Tirone Levels"
    case .trend:
      return "Trend Line"
    case .vertical:
      return "Vertical"
    case .noTool:
      return "No Tool"
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
    case .check:
      return .markings
    case .continuous:
      return .lines
    case .cross:
      return .markings
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
    case .focus:
      return .markings
    case .gannFan:
      return .technicals
    case .gartley:
      return .technicals
    case .heart:
      return .markings
    case .horizontal:
      return .lines
    case .line:
      return .lines
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
    case .segment:
      return .lines
    case .speedResistanceArc:
      return .technicals
    case .speedResistanceLine:
      return .technicals
    case .star:
      return .markings
    case .timeCycle:
      return .technicals
    case .tironeLevels:
      return .statistics
    case .trend:
      return .text
    case .vertical:
      return .lines
    case .noTool:
      return .text
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
      "arrow": .arrow,
      "average": .average,
      "callout": .callout,
      "channel": .channel,
      "check": .check,
      "continuous": .continuous,
      "xcross": .cross,
      "crossline": .crossline,
      "freeform": .doodle,
      "elliottwave": .elliottWave,
      "ellipse": .ellipse,
      "fibarc": .fibArc,
      "fibfan": .fibFan,
      "fibprojection": .fibProjection,
      "fibonacci": .fibRetracement,
      "fibtimezone": .fibTimeZone,
      "focusarrow": .focus,
      "gannfan": .gannFan,
      "gartley": .gartley,
      "heart": .heart,
      "horizontal": .horizontal,
      "line": .line,
      "pitchfork": .pitchfork,
      "quadrant": .quadrantLines,
      "ray": .ray,
      "rectangle": .rectangle,
      "regression": .regression,
      "segment": .segment,
      "speedarc": .speedResistanceArc,
      "speedline": .speedResistanceLine,
      "star": .star,
      "timecycle": .timeCycle,
      "tirone": .tironeLevels,
      "trendline": .trend,
      "vertical": .vertical,
      "notool": .noTool,
      "measure": .measure
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}
