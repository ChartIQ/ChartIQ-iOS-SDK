//
//  FibInputTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - FibInputTableCell ViewModel

class FibInputTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var placeholder: String
  internal var buttonTitle: String
  internal var isAllowNegative: Bool

  // MARK: - Init

  init(title: String, placeholder: String, buttonTitle: String, isAllowNegative: Bool) {
    self.title = title
    self.placeholder = placeholder
    self.buttonTitle = buttonTitle
    self.isAllowNegative = isAllowNegative
  }
}
