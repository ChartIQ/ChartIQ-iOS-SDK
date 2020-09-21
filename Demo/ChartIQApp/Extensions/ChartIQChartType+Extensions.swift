//
//  ChartIQChartType+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ChartIQChartType Images Extension

extension ChartIQChartType {

  // MARK: - Internal Properties

  internal var typeImage: UIImage? {
    switch self {
    case .candle:
      return UIImage.ChartIQChartType.candleImage
    case .bar:
      return UIImage.ChartIQChartType.barImage
    case .coloredBar:
      return UIImage.ChartIQChartType.coloredBarImage
    case .line:
      return UIImage.ChartIQChartType.lineImage
    case .vertexLine:
      return UIImage.ChartIQChartType.vertexLineImage
    case .step:
      return UIImage.ChartIQChartType.stepImage
    case .mountain:
      return UIImage.ChartIQChartType.mountainImage
    case .baseline:
      return UIImage.ChartIQChartType.baselineImage
    case .hollowCandle:
      return UIImage.ChartIQChartType.hollowCandleImage
    case .volumeCandle:
      return UIImage.ChartIQChartType.volumeCandleImage
    case .coloredHLCBar:
      return UIImage.ChartIQChartType.coloredHLCBarImage
    case .scatterplot:
      return UIImage.ChartIQChartType.scatterplotImage
    case .histogram:
      return UIImage.ChartIQChartType.histogramImage
    }
  }
}
