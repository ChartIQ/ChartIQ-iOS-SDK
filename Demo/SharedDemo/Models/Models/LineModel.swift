//
//  LineModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Line Model

struct LineModel: Equatable {

  // MARK: - Internal Properties

  internal let lineType: ChartIQLineType
  internal let lineWidth: Int
  internal let lineImage: UIImage?

  // MARK: - Init

  init(lineType: ChartIQLineType, lineWidth: Int) {
    self.lineType = lineType
    self.lineWidth = lineWidth
    self.lineImage = lineType.lineImage(forLineWidth: lineWidth)
  }
}
