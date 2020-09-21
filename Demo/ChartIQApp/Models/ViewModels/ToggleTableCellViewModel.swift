//
//  ToggleTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - ToggleTableCell ViewModel

class ToggleTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var isToggleOn: Bool

  // MARK: - Init

  init(title: String, isToggleOn: Bool) {
    self.title = title
    self.isToggleOn = isToggleOn
  }
}
