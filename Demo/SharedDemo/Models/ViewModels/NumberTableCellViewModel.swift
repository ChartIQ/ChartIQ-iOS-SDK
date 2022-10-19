//
//  NumberTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - NumberTableCell ViewModel

class NumberTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var number: Double
  internal var shouldDisplayAsInt: Bool
  internal var shouldAllowNegative: Bool

  // MARK: - Init

  init(title: String, number: Double, shouldDisplayAsInt: Bool = false, shouldAllowNegative: Bool = false) {
    self.title = title
    self.number = number
    self.shouldDisplayAsInt = shouldDisplayAsInt
    self.shouldAllowNegative = shouldAllowNegative
  }
}
