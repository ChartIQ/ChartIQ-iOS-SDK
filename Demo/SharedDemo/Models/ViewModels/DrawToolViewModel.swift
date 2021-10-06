//
//  DrawToolViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - DrawTool ViewModel

class DrawToolViewModel {

  // MARK: - Internal Properties

  internal var displayName: String = ""
  internal var toolImage: UIImage?
  internal var isInFavorites: Bool?
  internal var drawingTool: ChartIQDrawingTool?

  // MARK: - Init

  init(drawingTool: ChartIQDrawingTool, isInFavorites: Bool? = nil) {
    self.drawingTool = drawingTool
    self.isInFavorites = isInFavorites
    self.displayName = drawingTool.displayName
    self.toolImage = drawingTool.toolImage
  }
}

// MARK: - DrawToolFilterType Enum

enum DrawToolFilterType: Int, CaseIterable {
  case all
  case favorites
  case text
  case statistics
  case technicals
  case fibonacci
  case markings
  case lines

  internal var displayName: String {
    switch self {
    case .all:
      return Const.DrawTools.allFilterItemTitle
    case .favorites:
      return Const.DrawTools.favoritesFilterItemTitle
    case .text:
      return Const.DrawTools.textFilterItemTitle
    case .statistics:
      return Const.DrawTools.statisticsFilterItemTitle
    case .technicals:
      return Const.DrawTools.technicalsFilterItemTitle
    case .fibonacci:
      return Const.DrawTools.fibonacciFilterItemTitle
    case .markings:
      return Const.DrawTools.markingsFilterItemTitle
    case .lines:
      return Const.DrawTools.linesFilterItemTitle
    }
  }

  internal var drawingToolType: ChartIQDrawingToolType? {
    switch self {
    case .all:
      return nil
    case .favorites:
      return nil
    case .text:
      return .text
    case .statistics:
      return .statistics
    case .technicals:
      return .technicals
    case .fibonacci:
      return .fibonacci
    case .markings:
      return .markings
    case .lines:
      return .lines
    }
  }

  internal init?(stringValue: String) {
    let dictionary: [String: DrawToolFilterType] = [
      Const.DrawTools.allFilterItemTitle: .all,
      Const.DrawTools.favoritesFilterItemTitle: .favorites,
      Const.DrawTools.textFilterItemTitle: .text,
      Const.DrawTools.statisticsFilterItemTitle: .statistics,
      Const.DrawTools.technicalsFilterItemTitle: .technicals,
      Const.DrawTools.fibonacciFilterItemTitle: .fibonacci,
      Const.DrawTools.markingsFilterItemTitle: .markings,
      Const.DrawTools.linesFilterItemTitle: .lines
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}
