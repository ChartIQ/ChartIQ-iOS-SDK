//
//  ChartIQChartAggregationType+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ChartIQChartAggregationType Images Extension

extension ChartIQChartAggregationType {

  // MARK: - Internal Properties

  internal var typeImage: UIImage? {
    switch self {
    case .heikinashi:
      return UIImage.ChartIQChartAggregationType.heikinashiImage
    case .kagi:
      return UIImage.ChartIQChartAggregationType.kagiImage
    case .linebreak:
      return UIImage.ChartIQChartAggregationType.linebreakImage
    case .renko:
      return UIImage.ChartIQChartAggregationType.renkoImage
    case .rangebars:
      return UIImage.ChartIQChartAggregationType.rangebarsImage
    case .pandf:
      return UIImage.ChartIQChartAggregationType.pandfImage
    }
  }
}
