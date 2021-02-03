//
//  FibSettingsTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - FibSettingsTableCell ViewModel

class FibSettingsTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var parameters: [[String: Any]]

  // MARK: - Init

  init(title: String, parameters: [[String: Any]]) {
    self.title = title
    self.parameters = parameters
  }
}
