//
//  DeviationModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - DeviationLevel enum

enum DeviationLevel {
  case first
  case second
  case third

  var colorKey: String {
    switch self {
    case .first:
      return ChartIQConst.DrawingTool.color1Key
    case .second:
      return ChartIQConst.DrawingTool.color2Key
    case .third:
      return ChartIQConst.DrawingTool.color3Key
    }
  }

  var activeKey: String {
    switch self {
    case .first:
      return ChartIQConst.DrawingTool.active1Key
    case .second:
      return ChartIQConst.DrawingTool.active2Key
    case .third:
      return ChartIQConst.DrawingTool.active3Key
    }
  }

  var widthKey: String {
    switch self {
    case .first:
      return ChartIQConst.DrawingTool.lineWidth1Key
    case .second:
      return ChartIQConst.DrawingTool.lineWidth2Key
    case .third:
      return ChartIQConst.DrawingTool.lineWidth3Key
    }
  }

  var patternKey: String {
    switch self {
    case .first:
      return ChartIQConst.DrawingTool.pattern1Key
    case .second:
      return ChartIQConst.DrawingTool.pattern2Key
    case .third:
      return ChartIQConst.DrawingTool.pattern3Key
    }
  }
}

// MARK: - Deviation Model

struct DeviationModel {

  // MARK: - Internal Properties

  internal let lineLevel: DeviationLevel
  internal let lineModel: LineModel
  internal let lineColor: UIColor
  internal let isLineSelected: Bool

  // MARK: - Init

  init(lineLevel: DeviationLevel, lineModel: LineModel, lineColor: UIColor, isLineSelected: Bool) {
    self.lineLevel = lineLevel
    self.lineModel = lineModel
    self.lineColor = lineColor
    self.isLineSelected = isLineSelected
  }

  init?(lineLevel: DeviationLevel, parameters: [String: Any], isDarkTheme: Bool = false) {
    guard let lineWidth = parameters[lineLevel.widthKey] as? Int,
          let pattern = parameters[lineLevel.patternKey] as? String,
          let lineType = ChartIQLineType(stringValue: pattern) else { return nil }
    self.lineLevel = lineLevel
    self.lineModel = LineModel(lineType: lineType, lineWidth: lineWidth)
    self.lineColor = .getDynamicColor(from: parameters, colorKey: lineLevel.colorKey, isDarkTheme: isDarkTheme)
    self.isLineSelected = parameters[lineLevel.activeKey] as? Bool ?? false
  }
}
