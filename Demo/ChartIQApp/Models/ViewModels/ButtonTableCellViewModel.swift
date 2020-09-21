//
//  ButtonTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - ButtonTableCell ViewModel

class ButtonTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var titleColor: UIColor

  // MARK: - Init

  init(title: String, titleColor: UIColor) {
    self.title = title
    self.titleColor = titleColor
  }
}
