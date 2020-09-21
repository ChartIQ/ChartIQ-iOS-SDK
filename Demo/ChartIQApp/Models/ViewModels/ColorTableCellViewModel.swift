//
//  ColorTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - ColorTableCell ViewModel

class ColorTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var color: UIColor

  // MARK: - Init

  init(title: String, color: UIColor) {
    self.title = title
    self.color = color
  }
}
