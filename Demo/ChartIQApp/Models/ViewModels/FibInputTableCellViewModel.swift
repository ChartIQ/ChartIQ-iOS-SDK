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

  // MARK: - Init

  init(title: String, placeholder: String, buttonTitle: String) {
    self.title = title
    self.placeholder = placeholder
    self.buttonTitle = buttonTitle
  }
}
