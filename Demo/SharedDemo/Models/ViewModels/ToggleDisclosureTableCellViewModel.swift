//
//  ToggleDisclosureTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ToggleDisclosureTableCell ViewModel

class ToggleDisclosureTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var isToggleOn: Bool

  // MARK: - Init

  init(title: String, isToggleOn: Bool) {
    self.title = title
    self.isToggleOn = isToggleOn
  }

  init(signal: ChartIQSignal) {
    self.title = LocalizationManager.shared().localize(signal.name)
    self.isToggleOn = signal.isEnabled
  }
}
