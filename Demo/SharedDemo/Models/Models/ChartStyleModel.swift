//
//  ChartStyleModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ChartStyle Model

struct ChartStyleModel: Equatable {

  // MARK: - Internal Properties

  internal let chartType: ChartIQChartType?
  internal let chartAggregationType: ChartIQChartAggregationType?
  internal let displayName: String
  internal let typeImage: UIImage?

  // MARK: - Init

  init(chartType: ChartIQChartType? = nil, chartAggregationType: ChartIQChartAggregationType? = nil) {
    self.chartType = chartType
    self.chartAggregationType = chartAggregationType

    if let chartAggregationType = chartAggregationType {
      self.displayName = chartAggregationType.displayName
      self.typeImage = chartAggregationType.typeImage
    } else {
      self.displayName = chartType?.displayName ?? ""
      self.typeImage = chartType?.typeImage
    }
  }
}
