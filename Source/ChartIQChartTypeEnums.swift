//
//  ChartIQChartTypeEnums.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - ChartIQChartType Enum

/// Chart type.
@objc public enum ChartIQChartType: Int {

  /// The candle option.
  case candle

  /// The bar option.
  case bar

  /// The coloredBar option.
  case coloredBar

  /// The line option.
  case line

  /// The vertexLine option.
  case vertexLine

  /// The step option.
  case step

  /// The mountain option.
  case mountain

  /// The baseline option.
  case baseline

  /// The hollowCandle option.
  case hollowCandle

  /// The volumeCandle option.
  case volumeCandle

  /// The coloredHLCBar option.
  case coloredHLCBar

  /// The scatterplot option.
  case scatterplot

  /// The histogram option.
  case histogram

  /// Chart type string value.
  public var stringValue: String {
    switch self {
    case .candle:
      return "candle"
    case .bar:
      return "bar"
    case .coloredBar:
      return "colored_bar"
    case .line:
      return "line"
    case .vertexLine:
      return "vertex_line"
    case .step:
      return "step"
    case .mountain:
      return "mountain"
    case .baseline:
      return "baseline_delta"
    case .hollowCandle:
      return "hollow_candle"
    case .volumeCandle:
      return "volume_candle"
    case .coloredHLCBar:
      return "colored_hlc"
    case .scatterplot:
      return "scatterplot"
    case .histogram:
      return "histogram"
    }
  }

  /// Chart type display name.
  public var displayName: String {
    switch self {
    case .candle:
      return "Candle"
    case .bar:
      return "Bar"
    case .coloredBar:
      return "Colored Bar"
    case .line:
      return "Line"
    case .vertexLine:
      return "Vertex Line"
    case .step:
      return "Step"
    case .mountain:
      return "Mountain"
    case .baseline:
      return "Baseline"
    case .hollowCandle:
      return "Hollow Candle"
    case .volumeCandle:
      return "Volume Candle"
    case .coloredHLCBar:
      return "Colored HLC Bar"
    case .scatterplot:
      return "Data Points"
    case .histogram:
      return "Histogram"
    }
  }

  /// Init chart type with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQChartType] = [
      "candle": .candle,
      "bar": .bar,
      "colored_bar": .coloredBar,
      "line": .line,
      "vertex_line": .vertexLine,
      "step": .step,
      "mountain": .mountain,
      "baseline_delta": .baseline,
      "hollow_candle": .hollowCandle,
      "volume_candle": .volumeCandle,
      "colored_hlc": .coloredHLCBar,
      "scatterplot": .scatterplot,
      "histogram": .histogram
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQAggregationType Enum

/// Chart aggregation type.
@objc public enum ChartIQChartAggregationType: Int {

  /// The heikinashi option.
  case heikinashi

  /// The kagi option.
  case kagi

  /// The linebreak option.
  case linebreak

  /// The renko option.
  case renko

  /// The rangebars option.
  case rangebars

  /// The pandf option.
  case pandf

  /// Chart aggregation type string value.
  public var stringValue: String {
    switch self {
    case .heikinashi:
      return "heikinashi"
    case .kagi:
      return "kagi"
    case .linebreak:
      return "linebreak"
    case .renko:
      return "renko"
    case .rangebars:
      return "rangebars"
    case .pandf:
      return "pandf"
    }
  }

  /// Chart aggregation type display name.
  public var displayName: String {
    switch self {
    case .heikinashi:
      return "Heikin Ashi"
    case .kagi:
      return "Kagi"
    case .linebreak:
      return "Line Break"
    case .renko:
      return "Renko"
    case .rangebars:
      return "Range Bars"
    case .pandf:
      return "Point & Figure"
    }
  }

  /// Init chart aggregation type with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQChartAggregationType] = [
      "heikinashi": .heikinashi,
      "kagi": .kagi,
      "linebreak": .linebreak,
      "renko": .renko,
      "rangebars": .rangebars,
      "pandf": .pandf
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}
