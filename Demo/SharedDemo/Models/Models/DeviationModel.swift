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

  init?(lineLevel: DeviationLevel, parameters: [String: Any]) {
    var lineColor = UIColor.blackColor
    var lineSelected = false
    switch lineLevel {
    case .first:
      lineSelected = parameters[ChartIQConst.DrawingTool.active1Key] as? Bool ?? false
      if let color = parameters[ChartIQConst.DrawingTool.color1Key] as? String,
         color.hasPrefix(Const.General.hashSymbol) {
        lineColor = UIColor(hexString: color.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      if let lineWidth = parameters[ChartIQConst.DrawingTool.lineWidth1Key] as? Int,
         let pattern = parameters[ChartIQConst.DrawingTool.pattern1Key] as? String,
         let lineType = ChartIQLineType(stringValue: pattern) {
        self.lineModel = LineModel(lineType: lineType, lineWidth: lineWidth)
      } else {
        return nil
      }
    case .second:
      lineSelected = parameters[ChartIQConst.DrawingTool.active2Key] as? Bool ?? false
      if let color = parameters[ChartIQConst.DrawingTool.color2Key] as? String,
         color.hasPrefix(Const.General.hashSymbol) {
        lineColor = UIColor(hexString: color.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      if let lineWidth = parameters[ChartIQConst.DrawingTool.lineWidth2Key] as? Int,
         let pattern = parameters[ChartIQConst.DrawingTool.pattern2Key] as? String,
         let lineType = ChartIQLineType(stringValue: pattern) {
        self.lineModel = LineModel(lineType: lineType, lineWidth: lineWidth)
      } else {
        return nil
      }
    case .third:
      lineSelected = parameters[ChartIQConst.DrawingTool.active3Key] as? Bool ?? false
      if let color = parameters[ChartIQConst.DrawingTool.color3Key] as? String,
         color.hasPrefix(Const.General.hashSymbol) {
        lineColor = UIColor(hexString: color.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      if let lineWidth = parameters[ChartIQConst.DrawingTool.lineWidth3Key] as? Int,
         let pattern = parameters[ChartIQConst.DrawingTool.pattern3Key] as? String,
         let lineType = ChartIQLineType(stringValue: pattern) {
        self.lineModel = LineModel(lineType: lineType, lineWidth: lineWidth)
      } else {
        return nil
      }
    }
    self.lineLevel = lineLevel
    self.lineColor = lineColor
    self.isLineSelected = lineSelected
  }
}
